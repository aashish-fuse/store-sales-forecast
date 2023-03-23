{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    self,
    flake-parts,
    ...
  } @ inputs: flake-parts.lib.mkFlake {inherit inputs;} {
    systems = ["x86_64-linux"];

    perSystem = {
      pkgs,
      system,
      ...
    }: {
      devShells.default = (pkgs.buildFHSUserEnv {
        name = "poetry-store-sales";

        targetPkgs = pkgs: (with pkgs; [
          (poetry.override {python3 = python310;})
          nodejs
          cudaPackages.cuda_cudart
          cudaPackages.cudnn
        ]);

        runScript = "bash";
      }).env;
    };
  };
}
