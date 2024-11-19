resource "vault_mount" "pki_root" {
  path                      = "pki_root_${local.domain_name_sanitized}"
  type                      = "pki"
  description               = "Root CA PKI mount for \"${var.root_domain_name}\" domain."
  default_lease_ttl_seconds = var.configuration.root.certificate_default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.configuration.root.certificate_max_lease_ttl_seconds
}

resource "vault_mount" "pki_intermediate" {
  path                      = "pki_intermediate_${local.domain_name_sanitized}"
  type                      = "pki"
  description               = "Intermediate CA PKI mount for \"${var.root_domain_name}\" subdomains."
  default_lease_ttl_seconds = var.configuration.intermediate.certificate_default_lease_ttl_seconds
  max_lease_ttl_seconds     = var.configuration.intermediate.certificate_max_lease_ttl_seconds
}