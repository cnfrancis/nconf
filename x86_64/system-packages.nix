{ config, lib, pkgs, ... }:

{# List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim
    wget
    rsync
    rclone
    ripgrep
    htop
    git
    uv
    python313Full
  ];
}
