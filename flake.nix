{
  description = "rccxd: A C Compiler written in Rust";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    # flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
  in {
    formatter."${system}" = pkgs.alejandra;

    packages."${system}".default = pkgs.rustPlatform.buildRustPackage {
      name = "rccxd";
      src = self;
      cargoLock.lockFile = ./Cargo.lock;
    };

    devShells."${system}".default = pkgs.mkShell {
      buildInputs = with pkgs; [
        cargo
        rustc
        alejandra
      ];
    };
  };
}
