{ config, lib, pkgs, ... }:
{

  #======= USUARIO =======#
  users.users.cogu = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"           # Permite usar o comando 'sudo' para privilégios administrativos
      "networkmanager"  # Permite gerenciar conexões de rede (Wi-Fi/Ethernet)
      "video"           # Permite acesso a recursos de vídeo (brilho, aceleração extra)
      "audio"           # Permite acesso ao subsistema de áudio
    ];
  };

}