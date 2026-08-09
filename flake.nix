{
  description = "tmux-git-finder - find git repositories and open them in tmux sessions";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: rec {
        default = tmux-git-finder;
        tmux-git-finder = pkgs.stdenvNoCC.mkDerivation {
          pname = "tmux-git-finder";
          version = "0-unstable-2026-08-09";
          src = self;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          dontBuild = true;

          installPhase = ''
            runHook preInstall
            install -Dm755 tmux-git-finder -t $out/bin
            runHook postInstall
          '';

          postFixup =
            let
              runtimeDeps = with pkgs; [
                tmux
                fzf
                git
                findutils
                gnused
                coreutils
              ];
            in
            ''
              wrapProgram $out/bin/tmux-git-finder --prefix PATH : ${pkgs.lib.makeBinPath runtimeDeps}
            '';

          meta = {
            description = "Find git repositories and open them in tmux sessions";
            mainProgram = "tmux-git-finder";
            platforms = systems;
          };
        };
      });

      overlays.default = final: prev: {
        tmux-git-finder = self.packages.${final.stdenv.hostPlatform.system}.tmux-git-finder;
      };
    };
}
