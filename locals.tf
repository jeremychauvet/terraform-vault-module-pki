locals {
  domain_name_sanitized = replace(var.root_domain_name, ".", "_dot_")
  organisational_unit   = var.issuer["organisational_unit"] == null ? "Unknown organizational unit" : var.issuer["organisational_unit"]
  organization_name     = var.issuer["organization_name"] == null ? "Unknown organization name" : title(var.issuer["organization_name"])
  country               = var.issuer["country"] == null ? "Unknown country" : title(var.issuer["country"])
  locality              = var.issuer["locality"] == null ? "Unknown locality" : title(var.issuer["locality"])
  province              = var.issuer["province"] == null ? "Unknown province" : title(var.issuer["province"])
  street_address        = var.issuer["street_address"] == null ? "Unknown street address" : var.issuer["street_address"]
  postal_code           = var.issuer["postal_code"] == null ? "Unknown postal code" : var.issuer["postal_code"]
  issuer_name           = var.issuer["issuer_name"] == null ? "Unknown issuer name" : title(var.issuer["issuer_name"])
}