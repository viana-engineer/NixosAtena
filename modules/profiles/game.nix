{ config, lib, pkgs, ... }:

{
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud
    heroic
    lutris
  ];

  programs.gamemode.enable = true;
}