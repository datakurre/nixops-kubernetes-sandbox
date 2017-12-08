let

  k8s-master = { ... }: {
    deployment.targetEnv = "virtualbox";
    deployment.virtualbox.headless = true;
  };

  k8s-worker = { ... }: {
    deployment.targetEnv = "virtualbox";
    deployment.virtualbox.headless = true;
  };

in {

  kubemaster   = k8s-master;
  kubeworker01 = k8s-worker;
  kubeworker02 = k8s-worker;

}
