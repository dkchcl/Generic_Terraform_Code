resource "azurerm_linux_function_app" "lfa" {
  for_each = var.function_app
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  service_plan_id            = azurerm_service_plan.example.id
  storage_account_name       = each.value.storage_account_name
  storage_account_access_key = azurerm_storage_account.example.primary_access_key
  dynamic "site_config" {
  for_each = each.value.site_config
    content {
      always_on                                     = site_config.value.always_on
      api_definition_url                            = site_config.value.api_definition_url
      api_management_api_id                         = site_config.value.api_management_api_id
      app_command_line                              = site_config.value.app_command_line
      app_scale_limit                               = site_config.value.app_scale_limit
      application_insights_connection_string        = site_config.value.application_insights_connection_string
      application_insights_key                      = site_config.value.application_insights_key
      application_stack                             = site_config.value.application_stack # Define as object() if needed
      app_service_logs                              = site_config.value.app_service_logs # Define as object() if needed
      container_registry_managed_identity_client_id = site_config.value.container_registry_managed_identity_client_id
      container_registry_use_managed_identity       = site_config.value.container_registry_use_managed_identity
      cors                                          = site_config.value.cors # Define as object() if needed
      default_documents                             = site_config.value.default_documents
      elastic_instance_minimum                      = site_config.value.elastic_instance_minimum
      ftps_state                                    = site_config.value.ftps_state # AllAllowed, FtpsOnly, Disabled
      health_check_path                             = site_config.value.health_check_path
      health_check_eviction_time_in_min             = site_config.value.health_check_eviction_time_in_min
      http2_enabled                                 = site_config.value.http2_enabled
      ip_restriction                                = site_config.value.ip_restriction # Define as list(object()) if needed
      ip_restriction_default_action                 = site_config.value.ip_restriction_default_action    # Allow, Deny
      load_balancing_mode                           = site_config.value.load_balancing_mode    # WeightedRoundRobin, LeastRequests, etc.
      managed_pipeline_mode                         = site_config.value.managed_pipeline_mode    # Integrated, Classic
      minimum_tls_version                           = site_config.value.minimum_tls_version    # 1.0, 1.1, 1.2, 1.3
      pre_warmed_instance_count                     = site_config.value.pre_warmed_instance_count
      remote_debugging_enabled                      = site_config.value.remote_debugging_enabled
      remote_debugging_version                      = site_config.value.remote_debugging_version # e.g., VS2022
      runtime_scale_monitoring_enabled              = site_config.value.runtime_scale_monitoring_enabled
      scm_ip_restriction                            = site_config.value.scm_ip_restriction # Define as list(object()) if needed
      scm_ip_restriction_default_action             = site_config.value.scm_ip_restriction_default_action
      scm_minimum_tls_version                       = site_config.value.scm_minimum_tls_version
      scm_use_main_ip_restriction                   = site_config.value.scm_use_main_ip_restriction
      use_32_bit_worker                             = site_config.value.use_32_bit_worker
      vnet_route_all_enabled                        = site_config.value.vnet_route_all_enabled
      websockets_enabled                            = site_config.value.websockets_enabled
      worker_count                                  = site_config.value.worker_count
    }
  }


  app_settings                                   = optional(map(string))

  dynamic "auth_settings"  {
  for_each = each.value.auth_settings
    content {
        
    }
  }

  dynamic "auth_settings_v2" {
  for_each = each.value.auth_settings_v2
    content {
        
    }
  }
  dynamic "backup" {
  for_each = each.value.backup
    content {
      
    }
  }                                         
    builtin_logging_enabled                        = optional(bool)
    client_certificate_enabled                     = optional(bool)
    client_certificate_mode                        = optional(string)
    client_certificate_exclusion_paths             = optional(string)
    connection_string                              = optional(any)
    daily_memory_time_quota                        = optional(number)
    enabled                                        = optional(bool)
    content_share_force_disabled                   = optional(bool)
    functions_extension_version                    = optional(string)
    ftp_publish_basic_authentication_enabled       = optional(bool)
    https_only                                     = optional(bool)
    public_network_access_enabled                  = optional(bool)
    identity                                       = optional(any)
    key_vault_reference_identity_id                = optional(string)
    storage_account                                = optional(any)
    sticky_settings                                = optional(any)
    storage_account_access_key                     = optional(string)
    storage_uses_managed_identity                  = optional(bool)
    storage_key_vault_secret_id                    = optional(string)
    tags                                           = optional(map(string))
    virtual_network_backup_restore_enabled         = optional(bool)
    virtual_network_subnet_id                      = optional(string)
    vnet_image_pull_enabled                        = optional(bool)
    webdeploy_publish_basic_authentication_enabled = optional(bool)
    zip_deploy_file                                = optional(string)






}


