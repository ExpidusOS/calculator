{
  description = "ExpidusOS Calculator";

  nixConfig = rec {
    trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g=" ];
    substituters = [ "https://cache.nixos.org" "https://cache.garnix.io" ];
    trusted-substituters = substituters;
    fallback = true;
    http2 = false;
  };

  inputs.expidus-sdk = {
    url = github:ExpidusOS/sdk;
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.nixpkgs.url = github:ExpidusOS/nixpkgs;

  outputs = { self, expidus-sdk, nixpkgs }:
    with expidus-sdk.lib;
    flake-utils.eachSystem flake-utils.allSystems (system:
      let
        pkgs = expidus-sdk.legacyPackages.${system};
        deps = builtins.fromJSON (readFile ./deps.json);
        shortRev = self.shortRev or (substring 7 7 fakeHash);
        shortRevCodes = map strings.charToInt (stringToCharacters shortRev);
        buildCode = foldr (a: b: "${toString a}${toString b}") "" shortRevCodes;

        shortVersion = builtins.elemAt (splitString "+" (builtins.elemAt deps 0).version) 0;
        version = "${shortVersion}+${buildCode}";
      in {
        packages.default = pkgs.flutter.buildFlutterApplication {
          pname = "expidus-calculator";
          version = "${shortVersion}+git-${shortRev}";

          src = cleanSource self;

          flutterBuildFlags = [
            "--dart-define=COMMIT_HASH=${shortRev}"
          ];

          depsListFile = ./deps.json;
          vendorHash = "sha256-7zXk8Y0zptjIPnXdLospGP5wCPp+HSeArmuRu/SZAHE=";

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
            license = licenses.gpl3;
            maintainers = with maintainers; [ RossComputerGuy ];
            platforms = [ "x86_64-linux" "aarch64-linux" ];
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (self.packages.${system}.default) pname version name;

          packages = with pkgs; [ flutter ];
        };
      });
}
