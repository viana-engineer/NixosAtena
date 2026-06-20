{ config, lib, pkgs, ... }:
{
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
        
    # --- Desenvolvimento e Ferramentas ---
    jetbrains.idea      # IDE IntelliJ IDEA focada em desenvolvimento JVM
    postman             # Ferramenta para testes, design e documentação de APIs
    dbeaver-bin         # Gerenciador de banco de dados e cliente SQL
    direnv              # Ferramenta que carrega variáveis de ambiente automaticamente ao entrar em diretórios
    nix-direnv          # Extensão de alta performance para integrar o direnv ao ecossistema Nix (evita recompilações desnecessárias)
  ];

}