# Packages for this host only

{ pkgs, ... }:
let

  python-packages = pkgs.python3.withPackages (
    ps: with ps; [
      requests
      pyquery # needed for hyprland-dots Weather script
    ]
  );

in
{

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages =
    (with pkgs; [
      # terminal
      fastfetch
      neofetch
      zsh
      zsh-autosuggestions
      zsh-syntax-highlighting
      zsh-powerlevel10k
      htop
      git
      tree
      gemini-cli
      # guis
      firefox
      # ide
      vscode
      jetbrains-toolbox
      # for kvm
      qemu
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      # tools
      ansible
      postman
      # dev languages runtimes
      openjdk11
      nodejs_20
      # dev tools
      maven
      yarn
      # Containers
      docker
      docker-compose
          
    ])
    ++ [
      python-packages
    ];

  programs = {

    steam = {
      enable = false;
      gamescopeSession.enable = false;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
    };

  };

    #  resolve issues with Ansible finding its Python interpreter
  systemd.tmpfiles.rules = [
    "L+ /usr/libexec/platform-python - - - - ${pkgs.python3Minimal}/bin/python3"
  ];
  services.openssh.enable = true;
}
