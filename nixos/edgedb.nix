{
  inputs,
  lib,
  pkgs,
  ...
}: let
  edgedb-server = inputs.edgedb.packages."x86_64-linux".edgedb-server;
  edgedb-cli = inputs.edgedb.packages.x86_64-linux.edgedb-cli;
  working-dir = "/var/lib/edgedb";
  bootstrap-server = pkgs.writeText "bootstrap.edgesql" ''
    ALTER ROLE edgedb SET password := "test";
  '';
in {
  environment.systemPackages = [
    edgedb-cli
    edgedb-server
  ];

  users.groups.edgedb = {};
  users.users.edgedb = {
    group = "edgedb";
    description = "EdgeDB Server";
    isSystemUser = true;
    packages = [
      edgedb-server
    ];
  };

  system.activationScripts = {
    edgedb-data-dir = {
      text = ''
        install -d -m 0755 -o edgedb -g edgedb ${working-dir}
      '';
    };
  };

  systemd.services = {
    "edgedb@" = {
      enable = true;
      after = ["network.target" "syslog.target"];
      description = "EdgeDB Database Service, instance %i";
      documentation = ["https://edgedb.com"];
      path = [edgedb-server];
      reload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      script = ''
        ${lib.getExe' edgedb-server "edgedb-server"} \
        --data-dir=${working-dir}/$1 \
        --disable-dynamic-system-config \
        --emit-server-status=${working-dir}/$1/status.json \
        --instance-name=$1 \
        --security=insecure_dev_mode \
        --tls-cert-mode=generate_self_signed \
        --admin-ui=enabled
      '';
      scriptArgs = "%i";
      serviceConfig = {
        Type = "simple";
        User = "edgedb";
        Group = "edgedb";
        KillMode = "mixed";
        TimeoutSec = 0;
        ExecStartPre = ''
          ${lib.getExe' edgedb-server "edgedb-server"} \
          --data-dir=${working-dir}/%i \
          --instance-name=%i \
          --disable-dynamic-system-config \
          --bootstrap-only \
          --bootstrap-command-file=${bootstrap-server}
        '';
      };
    };

    "edgedb@test" = {
      enable = true;
      overrideStrategy = "asDropin";
    };
  };
}
