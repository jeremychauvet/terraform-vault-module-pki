resource "vault_pki_secret_backend_root_sign_intermediate" "this" {
  backend     = vault_mount.pki_root.path
  common_name = "${local.organization_name} Trust Services"
  csr         = vault_pki_secret_backend_intermediate_cert_request.this.csr
  ttl         = var.configuration.intermediate.certificate_default_lease_ttl_seconds
  issuer_ref  = vault_pki_secret_backend_root_cert.this.issuer_id
  format      = "pem_bundle"
}