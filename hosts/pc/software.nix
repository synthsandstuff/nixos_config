{ config, pkgs, ...}:

{
	packages = with pkgs; [
		kicad
		cmake
		gcc
		gcc-arm-embedded
		plex-desktop
		lua
		clang-tools
	];
}
