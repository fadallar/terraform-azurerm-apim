resource "azurerm_api_management" "this" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  sku_type     = var.sku_type
  sku_capacity = var.sku_capacity

  sku_name = join("_", [var.sku_type, var.sku_capacity])

  identity {
    type         = var.identity_type
    identity_ids = var.identity_ids
  }

  public_ip_address_id          = var.public_ip_address_id
  public_network_access_enabled = var.public_network_access_enabled
  virtual_network_type          = var.virtual_network_type

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_type == "Internal" || virtual_network_type == "External" ? ["enabled"] : []
    content {

      subnet_id = var.apim_subnet_id

    }
  }

  zones = var.zones

  tags = merge(var.default_tags, var.extra_tags)
}

#-------------------------------
# Creation of the apim logger entity
#-------------------------------
resource "azurerm_api_management_logger" "this" {
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
  identifier               = "applicationinsights"
  resource_group_name      = var.resource_group_name
  api_management_name      = azurerm_api_management.this.name
  api_management_logger_id = azurerm_api_management_logger.this.id
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