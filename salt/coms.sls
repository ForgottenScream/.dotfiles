{% if grains['id'] == 'dom0' %}

coms--create-nonfree-template:
  qvm.clone:
    - name: template-Coms
    - source: debian-13-minimal

coms--create-app-qube:
  qvm.vm:
   - name: coms
   - present:
     - template: template-Coms
     - label: blue
   - prefs:
     - label: blue
   - features:
     - set:
       - menu-items: mullvad-browser.desktop signal-desktop.desktop st.desktop debian-uxterm.desktop thunar.desktop
   - require:
     - qvm: coms--create-nonfree-template

{% elif grains['id'] == 'template-Coms' %}

coms-install-apt-apps:
  pkg.installed:
    - pkgs:
      - curl
      - gpg
      - dunst
      - qubes-core-agent-passwordless-root
      - qubes-usb-proxy
      - qubes-core-agent-networking
      - qubes-core-agent-nautilus
      - qubes-core-agent-thunar
      - zenity
      - zathura
      - zathura-pdf-poppler
      - pipewire
      - pipewire-qubes
      - wireplumber
      - stterm

coms--create-desktop-entry:
  file.managed:
    - name: /usr/share/applications/st.desktop
    - contents: |
        [Desktop Entry]
        Version=1.0
        Type=Application
        Terminal=True
        Name=st
        GenericName=Simple Terminal
        Comment=Suckless Terminal
        Exec=st
    - mode: '644'
    - user: root
    - group: root
    - creates: /usr/share/applications/st.desktop

coms--download-signal-key:
  cmd.run:
    - name: curl -s https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > /usr/share/keyrings/signal-desktop-keyring.gpg
    - env:
      - https_proxy: http://localhost:8082
    - creates:
      - /usr/share/keyrings/signal-desktop-keyring.gpg

coms--add-signal-repository:
  pkgrepo.managed:
    - name: deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main
    - file: /etc/apt/sources.list.d/signal-desktop.list
    - aptkey: False
    - require:
      - cmd: coms--download-signal-key
    - require_in:
      - pkg: coms--install-signal

coms--install-signal:
  pkg.installed:
    - pkgs:
      - signal-desktop

coms--download-mullvad-key:
  cmd.run:
    - name: curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
    - env:
      - https_proxy: http://localhost:8082
    - creates:
      - /usr/share/keyrings/mullvad-keyring.asc

coms--add-mullvad-repository:
  pkgrepo.managed:
    - name: deb [arch=amd64 signed-by=/usr/share/keyrings/mullvad-keyring.asc] https://repository.mullvad.net/deb/stable stable main
    - file: /etc/apt/sources.list.d/mullvad.list
    - aptkey: False
    - require:
      - cmd: coms--download-mullvad-key
    - require_in:
      - pkg: coms--install-mullvad

coms--install-mullvad:
  pkg.installed:
    - pkgs:
      - mullvad-browser

{% endif %}
