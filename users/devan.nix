{ pkgs, ... }: 

{
	users.users.devan = {
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;
	};

	programs.fish.enable = true;
}
