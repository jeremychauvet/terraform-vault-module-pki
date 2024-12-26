resource "vault_pki_secret_backend_role" "root_ca" {
  backend          = vault_mount.pki_root.path
  name             = "role-root-${local.domain_name_sanitized}"
  issuer_ref       = vault_pki_secret_backend_issuer.root.issuer_ref
  ttl              = var.configuration.root.certificate_authority_validity_ttl_seconds
  allow_ip_sans    = true
  key_type         = "rsa"
  key_bits         = 4096
  allowed_domains  = flatten(concat([var.root_domain_name], (var.configuration.allowed_domains)))
  allow_subdomains = true
  ou               = ["*.${var.root_domain_name}"]
  organization     = [local.organization_name]
  country          = [local.country]
  locality         = [local.locality]
  province         = [local.province]
  street_address   = [local.street_address]
  postal_code      = [local.postal_code]
}

resource "vault_pki_secret_backend_role" "intermediate_ca" {
  backend          = vault_mount.pki_intermediate.path
  issuer_ref       = vault_pki_secret_backend_issuer.intermediate.issuer_ref
  ttl              = var.configuration.intermediate.certificate_authority_validity_ttl_seconds
  name             = "role-intermediate-${local.domain_name_sanitized}"
  key_type         = "rsa"
  key_bits         = 4096
  allowed_domains  = flatten(concat([var.root_domain_name], (var.configuration.allowed_domains)))
  allow_subdomains = true
  ou               = ["*.${var.root_domain_name}"]
  organization     = [local.organization_name]
  country          = [local.country]
  locality         = [local.locality]
  province         = [local.province]
  street_address   = [local.street_address]
  postal_code      = [local.postal_code]

  allow_ip_sans  = true
  allow_any_name = true

  depends_on = [
    vault_pki_secret_backend_role.intermediate_ca,
    vault_pki_secret_backend_role.root_ca,
  ]
}