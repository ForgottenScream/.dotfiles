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
       - menu-items: mullvad-browser.desktop thunar.desktop st.desktop teams-for-linux.desktop
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

dev-teams-for-linux-key:
  cmd.run:
    - name: curl -1sLf -o /tmp/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
    - creates: /tmp/teams-for-linux.asc
    - env:
      - https_proxy: http://localhost:8082
    - require:
      - pkg: dev-core-packages

dev-teams-for-linux-import:
  cmd.run:
    - name: rpm --import /tmp/teams-for-linux.asc
    - require:
      - cmd: dev-teams-for-linux-key

dev-teams-for-linux-repo:
  cmd.run:
    - name: curl -1sLf -o /etc/yum.repos.d/teams-for-linux.repo https://repo.teamsforlinux.de/rpm/teams-for-linux.repo
    - creates: /etc/yum.repos.d/teams-for-linux.repo
    - env:
      - https_proxy: http://localhost:8082
    - require:
      - cmd: dev-teams-for-linux-import

dev-teams-for-linux:
  pkg.installed:
    - pkgs:
      - teams-for-linux
    - refresh: True
    - require: 
      - cmd: dev-teams-for-linux-repo

{% elif grains['id'] == 'dev' %}

dev-dotfiles-install:
  cmd.run:
    - name: git clone https://github.com/ForgottenScream/.dotfiles.git /home/user/.dotfiles
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
