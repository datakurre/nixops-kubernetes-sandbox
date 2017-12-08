# nix-kubernetes create -d hello hello.nix
# nix-kubernetes deploy -d hello -n default
{
  default =
    { config, pkgs, ... }:
    {
      kubernetes.namespaces = {
        default = {
          name = "default";
        };
      };
      kubernetes.deployments.hello = {
        replicas = 3;
        pod.containers.hello = {
          image = "hello:latest";
          imagePullPolicy = "IfNotPresent";
          ports = [{ port = 8080; }];
          requests.memory = "128Mi";
          requests.cpu = "50m";
        };
      };
      kubernetes.services.hello.ports = [{
        name = "http";
        port = 8080;
      }];
    };
}
