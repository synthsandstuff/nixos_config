{ config, ... }:

{
	networking.networkmanager.enable = true;

	networking.firewall.enable = true;

    services.tailscale = {
        enable = true;

        useRoutingFeatures = "client";
    };
}
