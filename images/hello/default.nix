{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let

  service = callPackage ./service {};

in

dockerTools.buildImage {
  name = "hello";
  tag = "latest";
  contents = [ service ];
  config.Entrypoint = "/bin/service";
# config.User = "nobody";
# runAsRoot = ''
#   #!${stdenv.shell}
#   ${dockerTools.shadowSetup}
#   groupadd --system --gid 65534 nobody
#   useradd --system --uid 65534 --gid 65534 -d / -s /sbin/nologin nobody
#   echo "hosts: files dns" > /etc/nsswitch.conf
# '';
}
