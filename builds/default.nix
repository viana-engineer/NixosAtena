{ ... }:
{
      #======= MONTAGEM DA MAQUINA =======#
      imports =
    [ 
      ../hosts/venus
      ../modules/system
      ../modules/users/cogu.nix
      ../modules/profiles/dev.nix
      ../modules/profiles/home.nix
      ../modules/profiles/game.nix
    ];
}