let

  k8s-master = { ... }: {
    services.kubernetes.roles = [ "master" "node" ];
  };

  k8s-worker = { ... }: {
    services.kubernetes.roles = [ "node" ];
  };

in {

  network.description = "Kubernetes Network";

  defaults.imports = [
    ./kubernetes
    ./images
  ];

  kubemaster = k8s-master;
  kubeworker01 = k8s-worker;
  kubeworker02 = k8s-worker;

}
