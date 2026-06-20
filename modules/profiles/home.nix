{ config, lib, pkgs, ... }:
{
  #======= PACOTES =======#
  environment.systemPackages = with pkgs; [
    

    # --- Produtividade e Aplicativos --- #
    vscode              # Editor de código
    obsidian            # Notas e conhecimento
    gnome-tweaks        # Ajustes finos do GNOME
    discord             # Comunicação
    qbittorrent         # Gerenciador de torrents

    
    
  ];

}