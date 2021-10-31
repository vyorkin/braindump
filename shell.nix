with import <nixpkgs> {};

pkgs.mkShell {
  buildInputs = with pkgs; [
    hugo
    python38Packages.pathlib2
  ];
}
