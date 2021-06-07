resource "google_container_cluster" "my-cluster" {
  name                     = "my-cluster"
  location                 = "us-central1-c"
  initial_node_count       = 1
  remove_default_node_pool = true
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "my-node-pool"
  location   = "us-central1-c"
  cluster    = google_container_cluster.my-cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-small"
  }

  autoscaling {
    min_node_count = 0
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
}

# Static IP used by the ingress
resource "google_compute_global_address" "backend_filmes" {
  name = "backend-filmes"
}
