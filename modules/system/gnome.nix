{ config, lib, pkgs, ... }:
{
  #======= INTEFACE GNOME =======#
  services.xserver.enable = true;               # Habilita o servidor X11 (base para exibir janelas)
  services.displayManager.gdm.enable = true;    # Ativa o GDM (tela de login do GNOME)
  services.desktopManager.gnome.enable = true;  # Ativa o ambiente desktop GNOME
  

  environment.systemPackages = with pkgs; [
    morewaita-icon-theme
    tokyonight-gtk-theme
  ];

fonts.packages = with pkgs; [
  corefonts

  liberation_ttf
  liberation-sans-narrow
  carlito
  caladea

  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-cjk-serif
  noto-fonts-color-emoji

  dejavu_fonts

  inter
  roboto
  open-sans
  lato
  montserrat
  poppins

  source-serif
  libertinus

  source-code-pro
  nerd-fonts.jetbrains-mono
  nerd-fonts.fira-code

  source-sans
  source-han-sans
];
}