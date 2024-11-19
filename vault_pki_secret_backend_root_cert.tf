resource "vault_pki_secret_backend_root_cert" "this" {
  depends_on            = [vault_mount.pki_root]
  backend               = vault_mount.pki_root.path
  ttl                   = var.configuration.root.certificate_authority_validity_ttl_seconds
  type                  = "internal"
  common_name           = "${local.organization_name} Root CA"
  permitted_dns_domains = ["*.${var.vault_cluster_url}"]
  format                = "pem"
  private_key_format    = "der"
  key_type              = "rsa"
  key_bits              = 4096
  exclude_cn_from_sans  = true
  ou                    = local.organisational_unit
  organization          = local.organization_name
  country               = local.country
  locality              = local.locality
  province              = local.province
  street_address        = local.street_address
  postal_code           = local.postal_code
  issuer_name           = local.issuer_name
}
