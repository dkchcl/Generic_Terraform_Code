resource "azurerm_storage_account" "stg" {
  for_each            = var.storage_account
  name                = each.value.name
  resource_group_name = each.value.resource_group_name

  location                          = each.value.location
  account_tier                      = each.value.account_tier
  account_replication_type          = each.value.account_replication_type
  account_kind                      = each.value.account_kind
  provisioned_billing_model_version = each.value.provisioned_billing_model_version
  cross_tenant_replication_enabled  = each.value.cross_tenant_replication_enabled
  access_tier                       = each.value.access_tier
  edge_zone                         = each.value.edge_zone
  https_traffic_only_enabled        = each.value.https_traffic_only_enabled
  min_tls_version                   = each.value.min_tls_version
  allow_nested_items_to_be_public   = each.value.allow_nested_items_to_be_public
  shared_access_key_enabled         = each.value.shared_access_key_enabled
  public_network_access_enabled     = each.value.public_network_access_enabled
  default_to_oauth_authentication   = each.value.default_to_oauth_authentication
  is_hns_enabled                    = each.value.is_hns_enabled
  nfsv3_enabled                     = each.value.nfsv3_enabled

  dynamic "custom_domain" {
    for_each = var.custom_domain
    content {
      name          = custom_domain.value.name
      use_subdomain = custom_domain.value.use_subdomain
    }
  }

  customer_managed_key {
    key_vault_key_id          = each.value.key_vault_key_id
    managed_hsm_key_id        = each.value.managed_hsm_key_id
    user_assigned_identity_id = each.value.user_assigned_identity_id

  }

  dynamic "identity" {
    for_each = var.identity
    content {
      type         = identity.value.type #SystemAssigned
      identity_ids = identity.value.identity_ids
    }
  }

  blob_properties {
    cors_rule {
      allowed_headers    = each.value.allowed_headers
      allowed_methods    = each.value.allowed_methods
      allowed_origins    = each.value.allowed_origins
      exposed_headers    = each.value.exposed_headers
      max_age_in_seconds = each.value.max_age_in_seconds
      #       allowed_headers    = ["*"]
      # allowed_methods    = ["GET", "HEAD", "POST", "OPTIONS", "MERGE", "PUT"]
      # allowed_origins    = ["*"]
      # exposed_headers    = ["*"]
      # max_age_in_seconds = 200
    }
    delete_retention_policy {
      days                     = each.value.delete_retention_policy_days
      permanent_delete_enabled = each.value.permanent_delete_enabled

      #       days                     = lookup(each.value, "delete_retention_policy_days", 7)
      # permanent_delete_enabled = false
    }
    restore_policy {
      days = each.value.restore_policy_days
      # days = 7
    }
    versioning_enabled            = each.value.blob_versioning_enabled
    change_feed_enabled           = each.value.change_feed_enabled
    change_feed_retention_in_days = each.value.change_feed_retention_in_days
    default_service_version       = each.value.default_service_version
    last_access_time_enabled      = each.value.last_access_time_enabled
    #     change_feed_enabled           = true
    # change_feed_retention_in_days = 7
    # default_service_version       = "2020-06-12"
    # last_access_time_enabled      = true
    container_delete_retention_policy {
      days = each.value.container_delete_retention_policy_days
      # days = 7
    }
  }

  # queue_properties {
  #   cors_rule {
  #     allowed_headers    = ["*"]
  #     allowed_methods    = ["GET", "HEAD", "POST", "OPTIONS", "MERGE", "PUT"]
  #     allowed_origins    = ["*"]
  #     exposed_headers    = ["*"]
  #     max_age_in_seconds = 200
  #   }
  #   logging {
  #     delete                = true
  #     read                  = true
  #     write                 = true
  #     version               = "1.0"
  #     retention_policy_days = 7
  #   }
  #   minute_metrics {
  #     enabled               = true
  #     version               = "1.0"
  #     include_apis          = true
  #     retention_policy_days = 7
  #   }
  #   hour_metrics {
  #     enabled               = true
  #     include_apis          = true
  #     retention_policy_days = 7
  #     version               = "1.0"
  #   }
  # }

  dynamic "static_website" {
    for_each = var.static_website
    content {
      index_document     = static_website.value.index_document
      error_404_document = static_website.value.error_404_document
    }
  }

  share_properties {
    cors_rule {
      allowed_headers    = each.value.share_core_allowed_headers
      allowed_methods    = each.value.share_core_allowed_methods
      allowed_origins    = each.value.share_core_allowed_origins
      exposed_headers    = each.value.share_core_exposed_headers
      max_age_in_seconds = each.value.share_core_max_age_in_seconds
      #       allowed_headers    = ["*"]
      # allowed_methods    = ["GET", "HEAD", "POST", "OPTIONS", "MERGE", "PUT"]
      # allowed_origins    = ["*"]
      # exposed_headers    = ["*"]
      # max_age_in_seconds = 200
    }
    retention_policy {
      days = each.value.share_retention_policy_days
      # days = 7
    }
    smb {
      versions                        = each.value.smb_versions
      authentication_types            = each.value.authentication_types
      kerberos_ticket_encryption_type = each.value.kerberos_ticket_encryption_type
      channel_encryption_type         = each.value.channel_encryption_type
      multichannel_enabled            = each.value.multichannel_enabled
      #       versions                        = ["SMB3.0"]
      # authentication_types            = ["NTLMv2"]
      # kerberos_ticket_encryption_type = ["RC4-HMAC"]
      # channel_encryption_type         = ["AES-128-CCM"]
      # multichannel_enabled            = false
    }
  }

  network_rules {
    default_action             = each.value.default_action
    bypass                     = each.value.bypass
    ip_rules                   = each.value.ip_rules
    virtual_network_subnet_ids = each.value.virtual_network_subnet_ids
    private_link_access {
      endpoint_resource_id = each.value.endpoint_resource_id
      endpoint_tenant_id   = each.value.endpoint_tenant_id
    }
  }

  large_file_share_enabled = each.value.large_file_share_enabled
  local_user_enabled       = each.value.local_user_enabled

  azure_files_authentication {
    directory_type                 = each.value.directory_type
    default_share_level_permission = each.value.default_share_level_permission
    active_directory {
      domain_name         = each.value.domain_name
      domain_guid         = each.value.domain_guid
      domain_sid          = each.value.domain_sid
      storage_sid         = each.value.storage_sid
      forest_name         = each.value.forest_name
      netbios_domain_name = each.value.netbios_domain_name
    }
  }

  routing {
    publish_internet_endpoints  = each.value.publish_internet_endpoints
    publish_microsoft_endpoints = each.value.publish_microsoft_endpoints
    choice                      = each.value.choice
  }

  queue_encryption_key_type         = each.value.queue_encryption_key_type
  table_encryption_key_type         = each.value.table_encryption_key_type
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled

  immutability_policy {
    allow_protected_append_writes = each.value.allow_protected_append_writes
    state                         = each.value.immutability_policy_state
    period_since_creation_in_days = each.value.period_since_creation_in_days
    #     allow_protected_append_writes = true
    # state                         = "Locked"
    # period_since_creation_in_days = 30
  }

  sas_policy {
    expiration_period = each.value.sas_policy_expiration_period
    expiration_action = each.value.sas_policy_expiration_action
    #     expiration_period = "PT48H"
    # expiration_action = "Log"
  }

  allowed_copy_scope = each.value.allowed_copy_scope
  sftp_enabled       = each.value.sftp_enabled
  dns_endpoint_type  = each.value.dns_endpoint_type

}




