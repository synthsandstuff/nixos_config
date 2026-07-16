{ config, pkgs, lib, ... }:

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
		wl-clipboard
		grim
		slurp
		swappy
        nodejs
        waybar-mpris
        waybar-lyric
        gpu-usage-waybar
        swaynotificationcenter
        apple-cursor
	];

    xdg.icons.fallbackCursorThemes = [
        "macOS"
    ];

    programs.dconf.profiles.user.databases = [
        {
            settings = {
                "org/gnome/desktop/interface" = {
                    cursor-theme = "macOS";
                    cursor-size = lib.gvariant.mkInt32 24;
                };
            };
        }
    ];

    environment.variables = {
        XCURSOR_THEME = "macOS";
        XCURSOR_SIZE = "24";
    };

	programs.hyprland.enable = true;
	services.openssh.enable = true;
}
