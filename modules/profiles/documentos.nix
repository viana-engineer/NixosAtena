{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
    # --- Ferramentas pada PDF --- #
    poppler-utils       # Utilitários para extrair dados, textos e fontes de PDFs
    mupdf               # Visualizador de PDF leve e rápido com ferramentas de linha de comando
    qpdf                # Manipulação, inspeção, divisão e união de arquivos PDF
    pdfcpu              # Ferramenta avançada para validar, otimizar e editar PDFs
    # --- Gerenciamento de Fontes --- #
    font-manager        # Gerenciador gráfico para visualizar e organizar fontes instaladas
    ];
}