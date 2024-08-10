{
  description = "ru flake";
  inputs = {
    nixpkgs.url =
      "https://mirrors.ustc.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixpkgs.url = "nixpkgs/nixpkgs-unstable";
  };
  outputs = { self, nixpkgs, vscode-server, rust-overlay, ... }@inputs: {
    nixosConfigurations.rnix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # 这里导入之前我们使用的 configuration.nix，
        # 这样旧的配置文件仍然能生效
        ./configuration.nix
        ./ssh.nix
        ./user-conf.nix
        ./network.nix
        ./docker.nix
        ./bash.nix

        vscode-server.nixosModules.default
        ({ config, pkgs, ... }: {
          services.vscode-server.enable = true;
          services.vscode-server.enableFHS = true;
        })

        ({ pkgs, ... }: {
          nixpkgs.overlays = [ rust-overlay.overlays.default ];
          environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
        })
      ];
    };
  };
}
