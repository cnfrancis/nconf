{ config, lib, pkgs, ... }:

{
  users.groups."g_monitoring" = {
    name = "g_monitoring";
  };
  users.users."monitoring" = {
    name = "monitoring";
    isSystemUser = true;
    group = "g_monitoring";
    home = "/home/monitoring";
    description = "service account for monitoring";
    extraGroups = [
      "g_monitoring"
    ];
    autoSubUidGidRange = true;
    createHome = true;
    useDefaultShell = true;
  };

  services.prometheus.exporters.node = {
    enable = true;
    port = 9100;
    user = "monitoring";
    enabledCollectors = [
      "logind"
      "systemd"
    ];
    disabledCollectors = [
      "textfile"
    ];
    openFirewall = true;
  };
}