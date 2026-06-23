{ config, lib, pkgs, ... }:

{
  # --- Habilita o Steam --- #
  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    mangohud      # Exibe métricas de desempenho em tempo real
    lutris        # Gerenciador de jogos e launchers
  ];

  # --- Otimização de desempenho --- #
  programs.gamemode.enable = true;

}