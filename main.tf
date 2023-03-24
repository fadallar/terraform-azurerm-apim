resource "azurerm_api_management" "this" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  sku_name = join("_", [var.sku_type, var.sku_capacity])

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  public_ip_address_id          = var.virtual_network_type != "None" ? azurerm_public_ip.this[0].id : null
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_type          = var.virtual_network_type
  client_certificate_enabled    = var.client_certificate_enabled
  zones                         = var.zones

  tags = merge(var.default_tags, var.extra_tags)



  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_type == "Internal" || var.virtual_network_type == "External" ? ["enabled"] : []
    content {

      subnet_id = var.apim_subnet_id

    }
  }



  dynamic "certificate" {
    for_each = var.certificate_configuration
    content {
      encoded_certificate  = lookup(certificate.value, "encoded_certificate")
      certificate_password = lookup(certificate.value, "certificate_password")
      store_name           = lookup(certificate.value, "store_name")
    }
  }

  dynamic "hostname_configuration" {
    for_each = length(concat(
      var.management_hostname_configuration,
      var.portal_hostname_configuration,
      var.developer_portal_hostname_configuration,
      var.proxy_hostname_configuration,
    )) > 0 ? ["enabled"] : []

    content {
      dynamic "management" {
        for_each = var.management_hostname_configuration
        content {
          host_name                    = lookup(management.value, "host_name")
          key_vault_id                 = lookup(management.value, "key_vault_id", null)
          certificate                  = lookup(management.value, "certificate", null)
          certificate_password         = lookup(management.value, "certificate_password", null)
          negotiate_client_certificate = lookup(management.value, "negotiate_client_certificate", false)
        }
      }

      dynamic "portal" {
        for_each = var.portal_hostname_configuration
        content {
          host_name                    = lookup(portal.value, "host_name")
          key_vault_id                 = lookup(portal.value, "key_vault_id", null)
          certificate                  = lookup(portal.value, "certificate", null)
          certificate_password         = lookup(portal.value, "certificate_password", null)
          negotiate_client_certificate = lookup(portal.value, "negotiate_client_certificate", false)
        }
      }

      dynamic "developer_portal" {
        for_each = var.developer_portal_hostname_configuration
        content {
          host_name                    = lookup(developer_portal.value, "host_name")
          key_vault_id                 = lookup(developer_portal.value, "key_vault_id", null)
          certificate                  = lookup(developer_portal.value, "certificate", null)
          certificate_password         = lookup(developer_portal.value, "certificate_password", null)
          negotiate_client_certificate = lookup(developer_portal.value, "negotiate_client_certificate", false)
        }
      }

      dynamic "proxy" {
        for_each = var.proxy_hostname_configuration
        content {
          host_name                    = lookup(proxy.value, "host_name")
          default_ssl_binding          = lookup(proxy.value, "default_ssl_binding", false)
          key_vault_id                 = lookup(proxy.value, "key_vault_id", null)
          certificate                  = lookup(proxy.value, "certificate", null)
          certificate_password         = lookup(proxy.value, "certificate_password", null)
          negotiate_client_certificate = lookup(proxy.value, "negotiate_client_certificate", false)
        }
      }

      dynamic "scm" {
        for_each = var.scm_hostname_configuration
        content {
          host_name                    = lookup(scm.value, "host_name")
          key_vault_id                 = lookup(scm.value, "key_vault_id", null)
          certificate                  = lookup(scm.value, "certificate", null)
          certificate_password         = lookup(scm.value, "certificate_password", null)
          negotiate_client_certificate = lookup(scm.value, "negotiate_client_certificate", false)
        }
      }

    }
  }

  ### Required when APIM is deployed with Dedicated or Premium SKU creation time can be above the hour
  ### Make sure your pipeline allows longer deployment time
  timeouts {
    create = var.create-timeout
    delete = var.delete-timeout
    update = var.update-timeout
  }
  ####

  notification_sender_email = var.notification_sender_email

  dynamic "policy" {
    for_each = var.policy_configuration
    content {
      xml_content = lookup(policy.value, "xml_content", null)
      xml_link    = lookup(policy.value, "xml_link", null)
    }
  }

  protocols {
    enable_http2 = var.enable_http2
  }

  sign_in {
    enabled = var.enable_sign_in
  }

  sign_up {
    enabled = var.enable_sign_up
    dynamic "terms_of_service" {
      for_each = var.terms_of_service_configuration
      content {
        consent_required = lookup(terms_of_service.value, "consent_required")
        enabled          = lookup(terms_of_service.value, "enabled")
        text             = lookup(terms_of_service.value, "text")
      }
    }
  }

  dynamic "security" {
    for_each = var.ciphers_configuration
    content {
      enable_backend_ssl30  = lookup(security.value, "enable_backend_ssl30", false)
      enable_backend_tls10  = lookup(security.value, "enable_backend_tls10", false)
      enable_backend_tls11  = lookup(security.value, "enable_backend_tls11", false)
      enable_frontend_ssl30 = lookup(security.value, "enable_frontend_ssl30", false)
      enable_frontend_tls10 = lookup(security.value, "enable_frontend_tls10", false)
      enable_frontend_tls11 = lookup(security.value, "enable_frontend_tls11", false)

      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = lookup(security.value, "tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = lookup(security.value, "tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = lookup(security.value, "tls_ecdheRsa_with_aes128_cbc_sha_ciphers_enabled", lookup(security.value, "tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled", false))
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = lookup(security.value, "tls_ecdheRsa_with_aes256_cbc_sha_ciphers_enabled", lookup(security.value, "tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled", false))
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = lookup(security.value, "tls_rsa_with_aes128_cbc_sha256_ciphers_enabled", false)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = lookup(security.value, "tls_rsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = lookup(security.value, "tls_rsa_with_aes128_gcm_sha256_ciphers_enabled", false)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = lookup(security.value, "tls_rsa_with_aes256_cbc_sha256_ciphers_enabled", false)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = lookup(security.value, "tls_rsa_with_aes256_cbc_sha_ciphers_enabled", false)

      triple_des_ciphers_enabled = lookup(security.value, "triple_des_ciphers_enabled ", false)
    }
  }

}
#######depends_on = [azurerm_network_security_rule.management_apim]

#-------------------------------
# Creation of the apim logger entity
#-------------------------------
resource "azurerm_api_management_logger" "this" {
  count               = var.enable_app_insights ? 1 : 0
  name                = "apim-app-insights-logger"
  api_management_name = azurerm_api_management.this.name
  resource_group_name = var.resource_group_name
  resource_id         = var.app_insights_id

  application_insights {
    instrumentation_key = var.app_insigths_instrumentation_key
  }
}

#-------------------------------
# API management service diagnostic
#-------------------------------
resource "azurerm_api_management_diagnostic" "this" {
  count                    = var.app_insights_id != null ? 1 : 0
  identifier               = "applicationinsights"
  resource_group_name      = var.resource_group_name
  api_management_name      = azurerm_api_management.this.name
  api_management_logger_id = azurerm_api_management_logger.this[0].id
  ###### TO DO REVIEW BELOW CONFIG
  sampling_percentage = 100.0
  always_log_errors   = true
  verbosity           = "verbose" #possible value are verbose, error, information


  frontend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  frontend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }

  backend_request {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "accept",
      "origin",
    ]
  }

  backend_response {
    body_bytes = 32
    headers_to_log = [
      "content-type",
      "content-length",
      "origin",
    ]
  }
}
#####  END OF TO DO