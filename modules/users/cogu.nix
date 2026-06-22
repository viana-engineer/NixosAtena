{ config, lib, pkgs, ... }:
{

  #======= USUARIO =======#
  users.users.eugenio = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"           # Permite usar o comando 'sudo' para privilégios administrativos
      "networkmanager"  # Permite gerenciar conexões de rede (Wi-Fi/Ethernet)
      "video"           # Permite acesso a recursos de vídeo (brilho, aceleração extra)
      "audio"           # Permite acesso ao subsistema de áudio
    ];
  };

  environment.systemPackages = with pkgs; [
    morewaita-icon-theme
    tokyonight-gtk-theme
  ];

  fonts.packages = with pkgs; [
    source-code-pro
  ];

}