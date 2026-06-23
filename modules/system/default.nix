{ config, lib, pkgs, ... }:
{

  imports = [
    ./gnome.nix
  ];

  #======= COMANDO NIX E FLAKES =======#
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #======= DIRENV E NIX-DIRENV =======#
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };





  #======= LOCAL =======#
  time.timeZone = "America/Sao_Paulo";  # Fuso horário local (Brasil)
  services.xserver.xkb.layout = "br";   # Configuração do teclado para layout ABNT2
  i18n.defaultLocale = "pt_BR.UTF-8";   # Idioma padrão do sistema
  # Suporte a múltiplos idiomas (Interface)
  i18n.supportedLocales = [
    "pt_BR.UTF-8/UTF-8"
    "zh_CN.UTF-8/UTF-8"
  ];

  # Método de entrada (Teclado/Digitação) | Ativa o IBus para gerenciar o Chinês
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
  };

  # Define o comportamento regional para garantir que formatos brasileiros sejam seguidos
  i18n.extraLocaleSettings = {
    LC_ADDRESS        = "pt_BR.UTF-8"; #de endereços postais
    LC_MEASUREMENT    = "pt_BR.UTF-8"; # Sistema de medidas (usa o sistema métrico: metros, quilos)
    LC_MONETARY       = "pt_BR.UTF-8"; # Formatos de moeda (ex: R$ 1.000,00)
    LC_TELEPHONE      = "pt_BR.UTF-8"; # Formatos de números de telefone
    LC_TIME           = "pt_BR.UTF-8"; # Formatos de data e hora (ex: DD/MM/AAAA)
  };

  #======= CONFIGURAÇÃO GERAL =======#
  
  # Permite a instalação de pacotes proprietários (não livres)
  nixpkgs.config.allowUnfree = true;

  # Habilita o navegador Firefox com integração otimizada ao sistema
  programs.firefox = {
    enable = true;
    
    preferences = {
      # Forçar o bloqueio de rastreamento por padrão
      "browser.trackingprotection.enabled" = true; 
    };
  };

  #======= REDE =======#
  # Habilita o NetworkManager para gerenciar conexões de rede
  # Permite configurar redes via terminal (nmcli/nmtui) ou via interface gráfica (GNOME)
  networking.networkmanager.enable = true;

  # Habilita CUPS para impressão de documentos.
  services.printing.enable = true;

  # Ferramenta diagnóstica de rede (combina ping e traceroute)
  programs.mtr.enable = true;
  # Habilita o GnuPG para segurança, assinatura de código e suporte a SSH
    programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  #======= SOM =======#
  services.pipewire = {
    enable = true;
    alsa.enable = true;   # Suporte ao ALSA (interface de baixo nível para o kernel do Linux)
    pulse.enable = true;  # Habilita compatibilidade com PulseAudio
    jack.enable = true;   # Habilita suporte ao JACK
  };

  #======= FIREWALL =======#
  # Mantemos o firewall ativado por segurança (padrão)
  networking.firewall.enable = false;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #======= SEGURANÇA DA CONFIGURAÇÃO =======#
  # Mantém uma cópia do configuration.nix no sistema.
  # (/run/current-system/configuration.nix). Local da copia
  #system.copySystemConfiguration = true;


}