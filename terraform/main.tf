provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "null_resource" "start_minikube" {
  provisioner "local-exec" {
    command = "./scripts/start_minikube.sh"
  }
}

resource "kubernetes_namespace" "test_namespace" {
  metadata {
    name = "kiratech-test"
  }

  depends_on = [null_resource.start_minikube]
}

resource "null_resource" "create_kube_bench_job" {
  depends_on = [kubernetes_namespace.test_namespace]

  provisioner "local-exec" {
    command = "kubectl apply -f /Users/serj/Kiratech/terraform/job.yaml -n kiratech-test"
  }
}

resource "null_resource" "security_benchmark" {
  depends_on = [null_resource.create_kube_bench_job]

  provisioner "local-exec" {
    command = <<EOF
      kubectl wait --for=condition=complete job/kube-bench -n kiratech-test
      kubectl logs job/kube-bench -n kiratech-test
    EOF
  }
}

resource "null_resource" "stop_minikube" {
  provisioner "local-exec" {
    command = "./scripts/stop_minikube.sh"
  }

  triggers = {
    cluster_destroyed = "${kubernetes_namespace.test_namespace.id}"
  }
}

output "kubeconfig_path" {
  value = "~/.kube/config"
}
