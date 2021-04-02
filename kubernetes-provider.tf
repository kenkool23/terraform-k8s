data "google_client_config" "default" {}

data "google_container_cluster" "gke-cluster" {
  name = "${var.app_name}-cluster"
  #zone = "us-east1-a"
}
provider "kubernetes" {
  host                   = "https://${google_container_cluster.gke-cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  client_certificate     = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.gke-cluster.master_auth.0.cluster_ca_certificate)
}
