resource "vault_pki_secret_backend_cert" "certificate" {
  for_each              = { for cert in var.certificates : cert.name => cert }
  issuer_ref            = vault_pki_secret_backend_issuer.intermediate.issuer_id
  backend               = vault_pki_secret_backend_role.intermediate_ca.backend
  name                  = vault_pki_secret_backend_role.intermediate_ca.name
  common_name           = each.value.do_not_append_root_domain_name == null || true ? each.value.name : "${each.value.name}.${var.root_domain_name}"
  ttl                   = each.value.ttl_in_seconds
  revoke                = each.value.revoke_on_destroy
}