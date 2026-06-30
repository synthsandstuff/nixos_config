{ config, pkgs, ... }:

{
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Set your time zone.
	time.timeZone = "Europe/London";
	time.hardwareClockInLocalTime = true;

	# Select internationalisation properties.
	i18n.defaultLocale = "en_GB.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_GB.UTF-8";
		LC_IDENTIFICATION = "en_GB.UTF-8";
		LC_MEASUREMENT = "en_GB.UTF-8";
		LC_MONETARY = "en_GB.UTF-8";
		LC_NAME = "en_GB.UTF-8";
		LC_NUMERIC = "en_GB.UTF-8";
		LC_PAPER = "en_GB.UTF-8";
		LC_TELEPHONE = "en_GB.UTF-8";
		LC_TIME = "en_GB.UTF-8";
	};

	programs.neovim = {
		enable = true;
		defaultEditor = true;
	};

	programs.ssh.startAgent = true;

	security.rtkit.enable = true;

	nix.gc = {
		automatic = true;
		randomizedDelaySec = "14m";
		options = "--delete-older-than 7d";
	};
}
