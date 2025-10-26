variable "function_app" {
  type = map(object({
    # Required
    name                = string
    resource_group_name = string
    location            = string
    service_plan_id     = string

    site_config = optional(object({
      always_on                                     = optional(bool)
      api_definition_url                            = optional(string)
      api_management_api_id                         = optional(string)
      app_command_line                              = optional(string)
      app_scale_limit                               = optional(number)
      application_insights_connection_string        = optional(string)
      application_insights_key                      = optional(string)
      application_stack                             = optional(any) # Define as object() if needed
      app_service_logs                              = optional(any) # Define as object() if needed
      container_registry_managed_identity_client_id = optional(string)
      container_registry_use_managed_identity       = optional(bool)
      cors                                          = optional(any) # Define as object() if needed
      default_documents                             = optional(list(string))
      elastic_instance_minimum                      = optional(number)
      ftps_state                                    = optional(string) # AllAllowed, FtpsOnly, Disabled
      health_check_path                             = optional(string)
      health_check_eviction_time_in_min             = optional(number)
      http2_enabled                                 = optional(bool)
      ip_restriction                                = optional(list(any)) # Define as list(object()) if needed
      ip_restriction_default_action                 = optional(string)    # Allow, Deny
      load_balancing_mode                           = optional(string)    # WeightedRoundRobin, LeastRequests, etc.
      managed_pipeline_mode                         = optional(string)    # Integrated, Classic
      minimum_tls_version                           = optional(string)    # 1.0, 1.1, 1.2, 1.3
      pre_warmed_instance_count                     = optional(number)
      remote_debugging_enabled                      = optional(bool)
      remote_debugging_version                      = optional(string) # e.g., VS2022
      runtime_scale_monitoring_enabled              = optional(bool)
      scm_ip_restriction                            = optional(list(any)) # Define as list(object()) if needed
      scm_ip_restriction_default_action             = optional(string)
      scm_minimum_tls_version                       = optional(string)
      scm_use_main_ip_restriction                   = optional(bool)
      use_32_bit_worker                             = optional(bool)
      vnet_route_all_enabled                        = optional(bool)
      websockets_enabled                            = optional(bool)
      worker_count                                  = optional(number)
    }))

    # Optional
    storage_account_name                           = optional(string)
    app_settings                                   = optional(map(string))
    auth_settings                                  = optional(any)
    auth_settings_v2                               = optional(any)
    backup                                         = optional(any)
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
  }))
  description = "Complete configuration for azurerm_linux_function_app including required and optional arguments."
}

