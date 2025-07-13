{ config, lib, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    package = pkgs.postgresql_17;
    ensureDatabases = [ "arbiter" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host  all      all     192.168.2.0/24   md5
    '';
    ensureUsers = [{
      name = "arbiter";
      ensureDBOwnership = true;
    }];
  };
  services.prometheus.exporters.postgres = {
      enable = true;
      listenAddress = "0.0.0.0";
      port = 9187;
  };
}