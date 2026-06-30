{ config, pkgs, ... }:

{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	boot.kernelPackages = pkgs.linuxPackages_latest;

	hardware.graphics = {
		enable = true;
		enable32Bit = true;
	};
}
