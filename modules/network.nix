{ config, ... }:

{
	networking.networkmanager.enable = true;

	networking.firewall.enable = true;

    services.tailscale = {
        enable = true;

        useRoutingFeatures = "client";
    };

    services.openssh = {
        enable = true;
        ports = [ 22 ];
        openFirewall = true;
        settings = {
            PasswordAuthentication = false;
            AllowUsers = null;
            UseDns = true;
            X11Forwarding = false;
            PermitRootLogin = "no";
        };
    };
}
