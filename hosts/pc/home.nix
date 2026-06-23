{ config, pkgs, ... }:


{
	xdg.portal = {
		enable = true;
		extraPortals = [pkgs.xdg-desktop-portal-gtk];
	};
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  home = {
  	username = "devan";
  	homeDirectory = "/home/devan";
	stateVersion = "25.05"; # Please read the comment before changing.

	packages = with pkgs; [
		firefox
		vesktop	
		spotify
		alacritty
		tmux
		waybar
		dunst
		libnotify
		rofi-wayland
		pavucontrol
		btop
		git
		kicad
		flutter
		pico-sdk
		cmake
		gcc
		gcc-arm-embedded
		plex-desktop
		nodejs_24
		swappy
		playerctl
		grim
		slurp
		efm-langserver
		nixd
		lua
		clang-tools
		hyprpaper
		anki
		unzip
		wl-clipboard
  	];

  	sessionVariables = {
  		EDITOR = "nvim";
  	};

  };
  programs.home-manager.enable = true;
}
