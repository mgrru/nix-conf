{
  description = "ru flake";
  nixConfig = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "https://mirrors.ustc.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nixpkgs,
      vscode-server,
      rust-overlay,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.rnix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          # 这里导入之前我们使用的 configuration.nix，
          # 这样旧的配置文件仍然能生效
          ./sys-conf/configuration.nix
          ./sys-conf/user-conf.nix
          ./sys-conf/network.nix

          ./services/ssh.nix
          ./services/docker.nix
          ./services/dae.nix
          # ./services/v2raya.nix

          ./pkgs/global-pkgs.nix

          ./programs/bash.nix
          # ./programs/npm.nix
          ./programs/editor.nix
          ./programs/git.nix
          # ./programs/java.nix

          vscode-server.nixosModules.default
          (
            { config, pkgs, ... }:
            {
              services.vscode-server.enable = true;
              services.vscode-server.enableFHS = true;
            }
          )

          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
              # environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            }
          )
          
          (
            let
              java_version = 21;
            in
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                (final: prev: rec {
                  jdk = prev."jdk${toString java_version}";
                  maven = prev.maven.override { jre = jdk; };
                })
              ];
            }
          )

          # 将 home-manager 配置为 nixos 的一个 module
          # 这样在 nixos-rebuild switch 时，home-manager 配置也会被自动部署
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.ru = import ./home/vbox/home.nix;

            # 使用 home-manager.extraSpecialArgs 自定义传递给 ./home.nix 的参数
            # 取消注释下面这一行，就可以在 home.nix 中使用 flake 的所有 inputs 参数了
            home-manager.extraSpecialArgs = inputs;
          }

          {
            # given the users in this list the right to specify additional substituters via:
            #    1. `nixConfig.substituters` in `flake.nix`
            nix.settings.trusted-users = [ "ru" ];
          }
        ];
      };
    };
}
