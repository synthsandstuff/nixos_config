{ config, pkgs, ...}:

{
	environment.systemPackages = with pkgs; [
		blender
		kicad
		cmake
		gcc
		gcc-arm-embedded
		plex-desktop
		lua
		clang-tools
        karere
	];
}
