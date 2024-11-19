resource "vault_pki_secret_backend_config_issuers" "root_ca" {
  backend                       = vault_mount.pki_root.path
  default                       = vault_pki_secret_backend_issuer.root.issuer_id
  default_follows_latest_issuer = true
}

resource "vault_pki_secret_backend_config_issuers" "intermediate_ca" {
  backend                       = vault_mount.pki_intermediate.path
  default                       = vault_pki_secret_backend_issuer.intermediate.issuer_id
  default_follows_latest_issuer = true
}