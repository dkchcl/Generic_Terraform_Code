variable "storage_account" {
  type = map(object({
    name                              = string
    resource_group_name               = string
    location                          = string
    account_tier                      = string
    account_replication_type          = string
    account_kind                      = optional(string)
    provisioned_billing_model_version = optional(string)
    cross_tenant_replication_enabled  = optional(bool)
    access_tier                       = optional(string)
    edge_zone                         = optional(string)
    https_traffic_only_enabled        = optional(bool)
    min_tls_version                   = optional(string)
    allow_nested_items_to_be_public   = optional(bool)
    shared_access_key_enabled         = optional(bool)
    public_network_access_enabled     = optional(bool)
    default_to_oauth_authentication   = optional(bool)
    is_hns_enabled                    = optional(bool)
    nfsv3_enabled                     = optional(bool)
    large_file_share_enabled          = optional(bool)
    local_user_enabled                = optional(bool)
    queue_encryption_key_type         = optional(string)
    table_encryption_key_type         = optional(string)
    infrastructure_encryption_enabled = optional(bool)
    allowed_copy_scope                = optional(string)
    sftp_enabled                      = optional(bool)
    dns_endpoint_type                 = optional(string)

    # key_vault_key_id                       = optional(string)
    # managed_hsm_key_id                     = optional(string)
    # user_assigned_identity_id              = optional(string)
    blob_versioning_enabled                = optional(bool)
    default_action                         = optional(string)
    bypass                                 = optional(list(string))
    ip_rules                               = optional(list(string))
    virtual_network_subnet_ids             = optional(list(string))
    endpoint_resource_id                   = optional(string)
    endpoint_tenant_id                     = optional(string)
    directory_type                         = optional(string)
    default_share_level_permission         = optional(string)
    domain_name                            = optional(string)
    domain_guid                            = optional(string)
    domain_sid                             = optional(string)
    storage_sid                            = optional(string)
    forest_name                            = optional(string)
    netbios_domain_name                    = optional(string)
    publish_internet_endpoints             = optional(bool)
    publish_microsoft_endpoints            = optional(bool)
    choice                                 = optional(string)
    allowed_headers                        = optional(list(string), ["*"])
    allowed_methods                        = optional(list(string), ["GET", "HEAD", "POST", "OPTIONS", "MERGE", "PUT"])
    allowed_origins                        = optional(list(string), ["*"])
    exposed_headers                        = optional(list(string), ["*"])
    max_age_in_seconds                     = optional(number, 200)
    delete_retention_policy_days           = optional(number, 7)
    permanent_delete_enabled               = optional(bool)
    restore_policy_days                    = optional(number, 7)
    change_feed_enabled                    = optional(bool, true)
    change_feed_retention_in_days          = optional(number, 7)
    default_service_version                = optional(string, "2020-08-04")
    last_access_time_enabled               = optional(bool, false)
    container_delete_retention_policy_days = optional(number, 7)
    share_core_allowed_headers             = optional(list(string), ["*"])
    share_core_allowed_methods             = optional(list(string), ["GET", "HEAD", "POST", "OPTIONS", "MERGE", "PUT"])
    share_core_allowed_origins             = optional(list(string), ["*"])
    share_core_exposed_headers             = optional(list(string), ["*"])
    share_core_max_age_in_seconds          = optional(number, 200)
    share_retention_policy_days            = optional(number, 7)
    smb_versions                           = optional(list(string), ["SMB3.0"])
    authentication_types                   = optional(list(string), ["NTLMv2"])
    kerberos_ticket_encryption_type        = optional(list(string), ["RC4-HMAC"])
    channel_encryption_type                = optional(list(string), ["AES-128-CCM"])
    multichannel_enabled                   = optional(bool, false)
    allow_protected_append_writes          = optional(bool, true)
    immutability_policy_state              = optional(string, "Locked")
    period_since_creation_in_days          = optional(number, 30)
    sas_policy_expiration_period           = optional(string, "PT48H")
    sas_policy_expiration_action           = optional(string, "Log")


  }))
}

variable "custom_domain" {
  type = map(object({
    name          = string
    use_subdomain = optional(bool)
  }))
  default = {}
}

variable "identity" {
  type = map(object({
    type = string
  }))
  default = {}

}

variable "static_website" {
  type = map(object({
    index_document     = string
    error_404_document = optional(string)
    enabled            = optional(bool)
  }))
  default = {}

}






