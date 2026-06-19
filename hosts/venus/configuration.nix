# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  #======= COMANDO NIX E FLAKES =======#
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  #======= DIRENV E NIX-DIRENV =======#
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  #======= ACELERAÇÃO GRAFICA =======#
  hardware.graphics = {
    enable = true;          # Habilita a aceleração gráfica no sistema
    enable32Bit = true;     # Suporte para bibliotecas 32-bits (jogos/WINE)
    extraPackages = with pkgs; [
      mesa                  # Driver de código aberto para OpenGL e Vulkan (AMD/Intel)
      libva                 # Biblioteca de Aceleração de Vídeo (VA-API)
      libvdpau-va-gl        # Tradutor de VDPAU para VA-API (melhora compatibilidade de vídeo)
                            # Teste de aceleração de vídeo (requer 'libva-utils'): vainfo
                            # Teste de driver Vulkan (requer 'vulkan-tools'): vulkaninfo --summary
    ];
  };


  #======= INTEFACE GRAFICA =======#
  services.xserver.enable = true;               # Habilita o servidor X11 (base para exibir janelas)
  services.displayManager.gdm.enable = true;    # Ativa o GDM (tela de login do GNOME)
  services.desktopManager.gnome.enable = true;  # Ativa o ambiente desktop GNOME
  

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

  #======= PACOTES =======#
  environment.systemPackages = with pkgs; [
    # --- Ferramentas de Sistema e Terminal --- #
    vim                 # Editor de texto terminal
    wget                # Downloader via linha de comando
    htop btop           # Monitoramento de processos e recursos
    nvtopPackages.full  # Monitoramento específico de GPU (AMD/NVIDIA/Intel)
    pciutils            # Utilitários para hardware
    git                 # Controle de versão
    
    # --- Gráficos e Diagnóstico --- #
    libva-utils         # Diagnóstico de aceleração de vídeo (VA-API)
    vulkan-tools        # Diagnóstico Vulkan (vulkaninfo)
    pulseaudioFull      # Ferramenta de linha de comando para controle do servidor de áudio.
    
    # --- Produtividade e Aplicativos --- #
    vscode              # Editor de código
    obsidian            # Notas e conhecimento
    gnome-tweaks        # Ajustes finos do GNOME
    discord             # Comunicação
    qbittorrent         # Gerenciador de torrents

    
    # --- Desenvolvimento e Ferramentas ---
    jetbrains.idea      # IDE IntelliJ IDEA focada em desenvolvimento JVM
    postman             # Ferramenta para testes, design e documentação de APIs
    dbeaver-bin         # Gerenciador de banco de dados e cliente SQL
    direnv              # Ferramenta que carrega variáveis de ambiente automaticamente ao entrar em diretórios
    nix-direnv          # Extensão de alta performance para integrar o direnv ao ecossistema Nix (evita recompilações desnecessárias)
  ];

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

  #======= SWAP DE 8GB AUTOMATIZADO =======#
  swapDevices = [ { device = "/swapfile"; size = 8192; } ];

  #======= BOOTLOADER =======#
  # Gerenciador de boot: systemd-boot (Rápido e nativo UEFI)
  boot.loader.systemd-boot.enable = true;
  
  # Permite que o sistema gerencie as variáveis de boot na UEFI/BIOS
  boot.loader.efi.canTouchEfiVariables = true;

  #======= REDE =======#
  # Habilita o NetworkManager para gerenciar conexões de rede
  # Permite configurar redes via terminal (nmcli/nmtui) ou via interface gráfica (GNOME)
  networking.networkmanager.enable = true;

  networking.hostName = "nixos-atena";


  # Habilita CUPS para impressão de documentos.
  services.printing.enable = true;

  #======= SOM =======#
  services.pipewire = {
    enable = true;
    alsa.enable = true;   # Suporte ao ALSA (interface de baixo nível para o kernel do Linux)
    pulse.enable = true;  # Habilita compatibilidade com PulseAudio
    jack.enable = true;   # Habilita suporte ao JACK
  };


  
  # Ferramenta diagnóstica de rede (combina ping e traceroute)
  programs.mtr.enable = true;
  # Habilita o GnuPG para segurança, assinatura de código e suporte a SSH
    programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  #======= FIREWALL =======#
  # Mantemos o firewall ativado por segurança (padrão)
  networking.firewall.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  #======= SEGURANÇA DA CONFIGURAÇÃO =======#
  # Mantém uma cópia do configuration.nix no sistema.
  # (/run/current-system/configuration.nix). Local da copia
  #system.copySystemConfiguration = true;

  #======= VERSÃO DO ESTADO =======#
  # Esta variável controla a compatibilidade do sistema. 
  # Ela garante que o sistema mantenha o comportamento esperado da versão em que foi instalado.
  # Não altere este valor a menos que tenha certeza de que a migração é necessária.
  system.stateVersion = "25.11";

}

