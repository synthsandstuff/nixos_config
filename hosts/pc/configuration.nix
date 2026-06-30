{ config, pkgs, inputs, ... }:

{
	imports = [
      ./hardware-configuration.nix
	  ./software.nix
	];
	
	networking.hostName = "devan-nixpc"; # Define your hostname.

	system.stateVersion = "25.05"; # Did you read the comment?

	services.xserver.videoDrivers = ["nvidia"];

	services.hardware.openrgb = {
		enable = true;
		motherboard = "amd";
	};

	hardware.nvidia = {
		powerManagement.enable = false;
		powerManagement.finegrained = false;
		open = false;

		nvidiaSettings = true;
		package = config.boot.kernelPackages.nvidiaPackages.stable;
	};
}
