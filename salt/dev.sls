{% if grains['id'] == 'dom0' %}

dev--create-template:
  qvm.clone:
    - name: template-Dev
    - source: fedora-44-minimal

dev--create-app-qube:
  qvm.vm:
   - name: dev
   - present:
     - template: template-Dev
     - label: orange
   - prefs:
     - label: orange
   - features:
     - set:
       - menu-items: mullvad-browser.desktop thunar.desktop st.desktop
   - require:
     - qvm: dev--create-template

{% elif grains['id'] == 'template-Dev' %}

dev-core-packages:
  pkg.installed:
    - pkgs:
      - curl
      - qubes-core-agent-passwordless-root
      - qubes-usb-proxy
      - qubes-core-agent-networking
      - qubes-core-agent-thunar
      - zenity
      - zathura
      - zathura-pdf-poppler
      - pipewire
      - pipewire-qubes
      - wireplumber
      - git
      - tmux
      - w3m
      - zoxide
      - newsboat
      - jq
      - ripgrep
      - tree
      - neovim
      - zsh
      - zsh-syntax-highlighting
      - st

dev-user-shell:
  cmd.run:
    - name: usermod -s /usr/bin/zsh user
    - onlyif: "getent passwd user | cut -d: -f7 | grep -qv zsh"
    - require:
      - dev-core-packages

dev-mullvad-add-repo:
  cmd.run:
    - name: dnf config-manager addrepo --from-repofile=https://repository.mullvad.net/rpm/stable/mullvad.repo
    - creates: /etc/yum.repos.d/mullvad.repo
    - env:
      - https_proxy: http://localhost:8082
    - require:
      - pkg: dev-core-packages

dev-mullvad-browser:
  pkg.installed:
    - pkgs:
      - mullvad-browser
    - refresh: True
    - require:
      - cmd: dev-mullvad-add-repo

{% elif grains['id'] == 'dev' %}

dev-dotfiles-install:
  cmd.run:
    - name: git clone https://codeberg.org/ForgottenScream/.dotfiles.git /home/user/.dotfiles
    - unless: test -d /home/user/.dotfiles

dev-dotfiles-deploy:
  cmd.run:
    - name: /home/user/.dotfiles/install.sh
    - user: user
    - cwd: /home/user/.dotfiles
    - env:
      - HOME: /home/user
    - require:
      - cmd: dev-dotfiles-install

{% endif %}
