{ compiler ? "ghc7103", nixpkgs ? import <nixpkgs> {} }:
nixpkgs.pkgs.haskell.packages.${compiler}.callPackage ./homepage.nix { }
