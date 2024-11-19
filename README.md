# Hashicorp Vault as Private Certificate Authority

This Terraform module create a root and intermediate CA to generate X.509 certificates on demand.  

## Usage

```hcl
module "hashicorp_dot_com" {
  source            = "jeremychauvet/private-certificate-authority/vault"
  
  root_domain_name  = "hashicorp.com"
  vault_cluster_url = "https://vault.hashicorp.com"

  issuer = {
    organisational_unit = "hashicorp.com"
    organization_name   = "Hashicorp"
    country             = "US"
    locality            = "San Franscisco"
    province            = "California"
    street_address      = "101 2nd street, suite 700"
    postal_code         = "94105"
    issuer_name         = "Hashicorp"
  }

  configuration = {
    root = {
      certificate_default_lease_ttl_seconds = 315360000 # seconds (10 years)
      certificate_max_lease_ttl_seconds    = 315360000 # seconds (10 years)
      certificate_authority_validity_ttl_seconds = 630720000 # seconds (20 years)
    },
    intermediate = {
      certificate_default_lease_ttl_seconds = 7776000  # seconds (90 days)
      certificate_max_lease_ttl_seconds    = 10368000 # seconds (120 days)
      certificate_authority_validity_ttl_seconds = 31536000 # seconds (1 year)
    }
  }

  certificates = [
    {
      name              = "prometheus"
      ttl_in_seconds    = 2592000 # 30 days
      revoke_on_destroy = true
    },
    {
      name              = "grafana"
      ttl_in_seconds    = 2592000 # 30 days
      revoke_on_destroy = true
    },
    {
      name              = "consul"
      ttl_in_seconds    = 604800 # 7 days
      revoke_on_destroy = true
    },
    {
      name              = "jira"
      ttl_in_seconds    = 3888000 # 45 days
      revoke_on_destroy = true
    },
    {
      name              = "confluence"
      ttl_in_seconds    = 3888000 # 45 days
      revoke_on_destroy = true
    }
  ]
}
```