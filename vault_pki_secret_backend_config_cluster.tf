resource "vault_pki_secret_backend_config_cluster" "pki_root" {
  backend  = vault_mount.pki_root.path
  path     = "${var.vault_cluster_url}/v1/pki_root_${local.domain_name_sanitized}"
  aia_path = "${var.vault_cluster_url}/v1/pki_root_${local.domain_name_sanitized}"
}

resource "vault_pki_secret_backend_config_cluster" "pki_intermediate" {
  backend  = vault_mount.pki_intermediate.path
  path     = "${var.vault_cluster_url}/v1/pki_intermediate_${local.domain_name_sanitized}"
  aia_path = "${var.vault_cluster_url}/v1/pki_intermediate_${local.domain_name_sanitized}"
}