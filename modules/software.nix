{ config, pkgs, ... }:

{
	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		firefox
		alacritty
		tmux
		waybar
		vicinae
		git
		btop
		spotify
		vesktop
		hyprpaper
		nautilus
		hyprshutdown
		nerd-fonts.roboto-mono
		wl-clipboard
		grim
		slurp
		swappy
        nodejs
	];

	programs.hyprland.enable = true;
	services.openssh.enable = true;
}
