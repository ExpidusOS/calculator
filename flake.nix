{
  description = "ExpidusOS Calculator";

  nixConfig = rec {
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
    substituters = [ "https://cache.nixos.org" "https://cache.garnix.io" ];
    trusted-substituters = substituters;
    fallback = true;
    http2 = false;
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flutter-v322.url = "github:ExpidusOS/nixpkgs/feat/flutter-3.22.0";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    flutter-v322,
    ...
  }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        inherit (pkgs) lib;

        shortRev = self.shortRev or (lib.substring 7 7 lib.fakeHash);
        shortRevCodes = map lib.strings.charToInt (lib.stringToCharacters shortRev);
        buildCode = lib.foldr (a: b: "${toString a}${toString b}") "" shortRevCodes;

        shortVersion = "0.2.0";
        version = "${shortVersion}+${buildCode}";

        overlay = f: p: {
          expidus = p.expidus // {
            calculator = p.flutter.buildFlutterApplication {
              pname = "expidus-calculator";
              version = "${shortVersion}+git-${shortRev}";

              src = lib.cleanSource self;

              flutterBuildFlags = [
                "--dart-define=COMMIT_HASH=${shortRev}"
              ];

              pubspecLock = lib.importJSON ./pubspec.lock.json;

              gitHashes = {
                libtokyo = "sha256-Zn30UmppXnzhs+t+EQNwAhaTPjCCxoN0a+AbH6bietg=";
                libtokyo_flutter = "sha256-Zn30UmppXnzhs+t+EQNwAhaTPjCCxoN0a+AbH6bietg=";
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

              meta = with lib; {
                description = "ExpidusOS Calculator";
                homepage = "https://expidusos.com";
                license = licenses.gpl3;
                maintainers = with maintainers; [ RossComputerGuy ];
                platforms = [ "x86_64-linux" "aarch64-linux" ];
              };
            };
          };
        };
      in {
        legacyPackages = pkgs.appendOverlays [
          (f: p: rec {
            flutterPackages = p.recurseIntoAttrs (p.callPackages "${flutter-v322}/pkgs/development/compilers/flutter" {});
            flutter = flutterPackages.stable;
            flutter322 = flutterPackages.v3_22;
          })
          overlay
        ];

        packages.default = self.legacyPackages.${system}.expidus.calculator;

        devShells.default = self.legacyPackages.${system}.mkShell {
          inherit (self.packages.${system}.default) pname version name;

          inputsFrom = [ self.packages.${system}.default ];

          packages = with self.legacyPackages.${system}; [ flutter yq ];
        };
      });
}
