{ config, lib, pkgs, ... }:
{
  users.groups."g_arbiter" = {
    name = "g_arbiter";
  };
  users.users."arbiter" = {
    name = "arbiter";
    isSystemUser = true;
    group = "g_arbiter";
    home = "/home/arbiter";
    description = "service account for arbiter";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDBNxtSrU0oskWDxA4s8UzlomO97DqD3j8NfVzcWgprK cnfrancis@fedora"
    ];
    extraGroups = [
      "g_arbiter"
    ];
    createHome = true;
    useDefaultShell = true;
    subUidRanges = [{
      count = 65534;
      startUid = 100001;
    }];
    subGidRanges = [{
      count = 65534;
      startGid = 100001;
    }];
  };
}