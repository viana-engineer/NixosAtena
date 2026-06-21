{ config, lib, pkgs, ... }:

{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    lutris
  ];

  programs.gamemode.enable = true;
}