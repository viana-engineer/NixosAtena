{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  #======= HOSTNAME =======#
  networking.hostName = "venus";

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

  #======= SWAP DE 8GB AUTOMATIZADO =======#
  swapDevices = [ { device = "/swapfile"; size = 8192; } ];

  #======= BOOTLOADER =======#
  # Gerenciador de boot: systemd-boot (Rápido e nativo UEFI)
  boot.loader.systemd-boot.enable = true;
  
  # Permite que o sistema gerencie as variáveis de boot na UEFI/BIOS
  boot.loader.efi.canTouchEfiVariables = true;

  #======= VERSÃO DO ESTADO =======#
  # Esta variável controla a compatibilidade do sistema. 
  # Ela garante que o sistema mantenha o comportamento esperado da versão em que foi instalado.
  # Não altere este valor a menos que tenha certeza de que a migração é necessária.
  system.stateVersion = "25.11";

}