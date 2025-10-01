let
  sources = import ./npins;
  pkgs = import sources.nixpkgs {};
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    freetype
    alsa-lib
    curl
    gtk3
    jack2
    xorg.libX11
    xorg.libX11.dev
    xorg.libXext
    xorg.libXinerama
    xorg.xrandr
    xorg.libXcursor

    pcre2
    pcre
    libuuid
    libselinux
    libsepol
    libthai
    libdatrie
    libpsl
    xorg.libXdmcp
    libxkbcommon
    libepoxy
    xorg.libXtst
    libsysprof-capture
    sqlite.dev
    ninja
  ];
  nativeBuildInputs = with pkgs; [
    cmake
    pkg-config
    patchelf
    gdb
    clang-tools
  ];

  NIX_LDFLAGS = (toString [
    "-lX11"
    "-lXext"
    "-lXcursor"
    "-lXinerama"
    "-lXrandr"
  ]);
}
