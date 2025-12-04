resource "kubernetes_daemonset" "vm_max_map_count" {
  metadata {
    name      = "vm-max-map-count-setter"
    namespace = "kube-system"
    labels = {
      app = "vm-max-map-count-setter"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "vm-max-map-count-setter"
      }
    }

    template {
      metadata {
        labels = {
          app = "vm-max-map-count-setter"
        }
      }
      spec {
        host_pid = true
        container {
          name  = "sysctl"
          image = "busybox:latest"
          security_context {
            privileged = true
          }
          command = ["sh", "-c", "sysctl -w vm.max_map_count=262144 || true; sleep 3600"]
        }
      }
    }
  }
}
