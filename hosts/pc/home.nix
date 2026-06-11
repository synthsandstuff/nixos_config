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
  	];

  	sessionVariables = {
  		EDITOR = "nvim";
  	};

  	file = {
		".config/alacritty".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/alacritty";
		".config/btop".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/btop";
		".config/cava".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/cava";
		".config/coc".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/coc";
		".config/efm-langserver".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/efm-langserver";
		".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/hypr";
		".config/kicad".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/kicad";
		".config/neofetch".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/neofetch";
		".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/nvim";
		".config/tmux".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/tmux"; 
		"Wallpapers".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/wallpapers";
		".local/share/nvim/site/autoload".source = config.lib.file.mkOutOfStoreSymlink "/etc/nixos/dotfiles/vim-plug";
  	};
  };

  programs.home-manager.enable = true;
}
