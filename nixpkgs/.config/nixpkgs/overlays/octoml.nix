self: super: {
  # kubernetes-helm =
  #   let
  #     pkgs = import (fetchGit {
  #       url = "https://github.com/NixOS/nixpkgs.git";
  #       rev = "b27a19d5bf799f581a8afc2b554f178e58c1f524";
  #     }) { };
  #   in
  #     pkgs.kubernetes-helm;
}
