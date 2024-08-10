{
  description = "ru flake";
  inputs = {
    # nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs, vscode-server, fenix, ... }@inputs: {
    packages.x86_64-linux.default = fenix.packages.x86_64-linux.minimal.toolchain;
    nixosConfigurations.rnix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # 这里导入之前我们使用的 configuration.nix，
        # 这样旧的配置文件仍然能生效
        ./configuration.nix

        vscode-server.nixosModules.default
        ({ config, pkgs, ... }: {
          services.vscode-server.enable = true;
          services.vscode-server.enableFHS = true;
        })

        ({ pkgs, ... }: {
          nixpkgs.overlays = [ fenix.overlays.default ];
          environment.systemPackages = with pkgs; [
            (fenix.minimal.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
              "rust-analyzer"
            ])
          ];
        })
      ];
    };
  };
}
