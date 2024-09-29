{
  description = "ExpidusOS Calculator";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    systems.url = "github:nix-systems/default-linux";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, systems, flake-utils }:
    let
      inherit (nixpkgs) lib;
    in
    flake-utils.lib.eachSystem (import systems) (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        deps = builtins.fromJSON (lib.readFile ./deps.json);
        shortRev = self.shortRev or (lib.substring 7 7 lib.fakeHash);
        shortRevCodes = lib.map lib.strings.charToInt (lib.stringToCharacters shortRev);
        buildCode = lib.foldr (a: b: "${toString a}${toString b}") "" shortRevCodes;

        shortVersion = "1.0.0";
        version = "${shortVersion}+${buildCode}";
      in {
        packages.default = pkgs.flutter.buildFlutterApplication {
          pname = "expidus-calculator";
          version = "${shortVersion}+git-${shortRev}";

          src = lib.cleanSource self;

          flutterBuildFlags = [
            "--dart-define=COMMIT_HASH=${shortRev}"
          ];

          pubspecLock = lib.importJSON ./pubspec.lock.json;

          gitHashes = {
            expidus = "sha256-qAdgxZrsd2qUIB6NghRDeVNk2n3OJ/NBb0JzbmiM810=";
          };

          postInstall = ''
            rm $out/bin/calculator
            ln -s $out/app/calculator $out/bin/expidus-calculator

            mkdir -p $out/share/applications
            mv $out/app/data/com.expidusos.calculator.desktop $out/share/applications

            mkdir -p $out/share/icons
            mv $out/app/data/com.expidusos.calculator.png $out/share/icons

            mkdir -p $out/share/metainfo
            mv $out/app/data/com.expidusos.calculator.metainfo.xml $out/share/metainfo

            substituteInPlace "$out/share/applications/com.expidusos.calculator.desktop" \
              --replace "Exec=calculator" "Exec=$out/bin/expidus-calculator" \
              --replace "Icon=com.expidusos.calculator" "Icon=$out/share/icons/com.expidusos.calculator.png"
          '';

          meta = {
            description = "ExpidusOS Calculator";
            homepage = "https://expidusos.com";
            license = lib.licenses.gpl3;
            maintainers = with lib.maintainers; [ RossComputerGuy ];
            platforms = [ "x86_64-linux" "aarch64-linux" ];
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (self.packages.${system}.default) pname version name;

          packages = with pkgs; [
            flutter
            pkg-config
            gtk3
          ];
        };
      });
}
