resource "vault_pki_secret_backend_issuer" "root" {
  backend                        = vault_mount.pki_root.path
  issuer_ref                     = vault_pki_secret_backend_root_cert.this.issuer_id
  issuer_name                    = "root-ca-${local.domain_name_sanitized}"
  revocation_signature_algorithm = "SHA256WithRSA"
  issuing_certificates           = ["${var.vault_cluster_url}/v1/${vault_mount.pki_root.path}/ca"]
  crl_distribution_points        = ["${var.vault_cluster_url}/v1/${vault_mount.pki_root.path}/crl"]
}

resource "vault_pki_secret_backend_issuer" "intermediate" {
  backend                        = vault_mount.pki_intermediate.path
  issuer_ref                     = vault_pki_secret_backend_intermediate_set_signed.intermediate.imported_issuers[0]
  issuer_name                    = "intermediate-ca-${local.domain_name_sanitized}"
  revocation_signature_algorithm = "SHA256WithRSA"
  issuing_certificates           = ["${var.vault_cluster_url}/v1/${vault_mount.pki_intermediate.path}/ca"]
  crl_distribution_points        = ["${var.vault_cluster_url}/v1/${vault_mount.pki_intermediate.path}/crl"]
}