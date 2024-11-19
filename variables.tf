variable "root_domain_name" {
  type        = string
  description = "Full Qualified Domain Name for your root domain. Eg: hashicorp.com"
}

variable "vault_cluster_url" {
  type        = string
  description = "Fully Qualified Domain Name URL of your Vault cluster. Eg: https://vault.internal.hashicorp.com"
}

variable "issuer" {
  description = "Issuer information's."
  type = object({
    organisational_unit = optional(string)
    organization_name   = optional(string)
    country             = optional(string)
    locality            = optional(string)
    province            = optional(string)
    street_address      = optional(string)
    postal_code         = optional(string)
    issuer_name         = string
  })

  validation {
    condition     = length(var.issuer["country"]) == 2
    error_message = "According to the standards, the country code must be a 2-character code (like 'FR' for France)."
  }
}

variable "configuration" {
  type = object({
    root = object({
      certificate_default_lease_ttl_seconds = number
      certificate_max_lease_ttl_seconds    = number
      certificate_authority_validity_ttl_seconds = number
    }),
    intermediate = object({
      certificate_default_lease_ttl_seconds = number
      certificate_max_lease_ttl_seconds    = number
      certificate_authority_validity_ttl_seconds = number
    })
  })

  # Default values match the original configuration
  default = {
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
}

variable "certificates" {
  description = "List of certificates to manage."
  type = list(object({
    name              = string
    ttl_in_seconds    = number
    revoke_on_destroy = bool
  }))
}