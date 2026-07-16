{ pkgs, ... }: 

{
	users.users.devan = {
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.fish;
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAUE4wn/2mXepiJaCeoRWYIz9JRfOQDgRYRMRtjzbT8B devan@x86mac"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII+2+ktfe7iavXHp9EP1hK49kmaCMyrDM6t6Aaxj5r+M devan@armmac"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8KrYvhw0MhXpXRb9Zymxw+65l32tEnCQj8EFW9GANP devan@nixpc"
        ];
	};

	programs.fish.enable = true;
}
