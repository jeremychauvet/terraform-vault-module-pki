resource "vault_pki_secret_backend_intermediate_cert_request" "this" {
  backend        = vault_mount.pki_intermediate.path
  type           = "internal"
  common_name    = "*.${var.root_domain_name}"
  ou             = local.organisational_unit
  organization   = local.organization_name
  country        = local.country
  locality       = local.locality
  province       = local.province
  street_address = local.street_address
  postal_code    = local.postal_code
}

