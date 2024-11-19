resource "vault_pki_secret_backend_config_urls" "pki_root" {
  backend                 = vault_mount.pki_root.path
  issuing_certificates    = ["${var.vault_cluster_url}/v1/${vault_mount.pki_root.path}/ca"]
  crl_distribution_points = ["${var.vault_cluster_url}/v1/${vault_mount.pki_root.path}/crl"]
}

resource "vault_pki_secret_backend_config_urls" "pki_intermediate" {
  backend                 = vault_mount.pki_intermediate.path
  issuing_certificates    = ["${var.vault_cluster_url}/v1/${vault_mount.pki_intermediate.path}/ca"]
  crl_distribution_points = ["${var.vault_cluster_url}/v1/${vault_mount.pki_intermediate.path}/crl"]
}