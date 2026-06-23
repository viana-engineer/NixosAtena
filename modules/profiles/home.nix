{ config, lib, pkgs, ... }:
{
  
  environment.systemPackages = with pkgs; [
    

    # --- Produtividade e Aplicativos --- #
    vscode              # Editor de código
    obsidian            # Notas e conhecimento
    gnome-tweaks        # Ajustes finos do GNOME
    discord             # Comunicação
    qbittorrent         # Gerenciador de torrents
    libreoffice-fresh   # Suíte de escritório com os recursos mais recentes
    inkscape            # Editor vetorial para criar e editar SVGs, PDFs e ilustrações
   
  ];

}