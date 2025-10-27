# Multiple Linux VMs using for_each 
resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.linux_vms

  name                  = each.value.name
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = each.value.network_interface_ids
  size                  = each.value.size

  # Required block
  os_disk {
    caching                          = each.value.os_disk.caching
    storage_account_type             = lookup(each.value.os_disk, "storage_account_type", null)
    name                             = lookup(each.value.os_disk, "name", null)
    disk_size_gb                     = lookup(each.value.os_disk, "disk_size_gb", null)
    disk_encryption_set_id           = lookup(each.value.os_disk, "disk_encryption_set_id", null)
    secure_vm_disk_encryption_set_id = lookup(each.value.os_disk, "secure_vm_disk_encryption_set_id", null)
    security_encryption_type         = lookup(each.value.os_disk, "security_encryption_type", null)
    write_accelerator_enabled        = lookup(each.value.os_disk, "write_accelerator_enabled", null)

    dynamic "diff_disk_settings" {
      for_each = lookup(each.value.os_disk, "diff_disk_settings", null) == null ? [] : [each.value.os_disk.diff_disk_settings]
      content {
        option    = diff_disk_settings.value.option
        placement = lookup(diff_disk_settings.value, "placement", null)
      }
    }
  }

  # Optional arguments (Terraform ignores nulls)
  admin_username                                         = lookup(each.value, "admin_username", null)
  admin_password                                         = lookup(each.value, "admin_password", null)
  disable_password_authentication                        = lookup(each.value, "disable_password_authentication", null)
  computer_name                                          = lookup(each.value, "computer_name", null)
  custom_data                                            = lookup(each.value, "custom_data", null)
  allow_extension_operations                             = lookup(each.value, "allow_extension_operations", null)
  availability_set_id                                    = lookup(each.value, "availability_set_id", null)
  license_type                                           = lookup(each.value, "license_type", null)
  capacity_reservation_group_id                          = lookup(each.value, "capacity_reservation_group_id", null)
  dedicated_host_id                                      = lookup(each.value, "dedicated_host_id", null)
  dedicated_host_group_id                                = lookup(each.value, "dedicated_host_group_id", null)
  encryption_at_host_enabled                             = lookup(each.value, "encryption_at_host_enabled", null)
  eviction_policy                                        = lookup(each.value, "eviction_policy", null)
  max_bid_price                                          = lookup(each.value, "max_bid_price", null)
  patch_mode                                             = lookup(each.value, "patch_mode", null)
  patch_assessment_mode                                  = lookup(each.value, "patch_assessment_mode", null)
  bypass_platform_safety_checks_on_user_schedule_enabled = lookup(each.value, "bypass_platform_safety_checks_on_user_schedule_enabled", null)
  reboot_setting                                         = lookup(each.value, "reboot_setting", null)
  priority                                               = lookup(each.value, "priority", null)
  secure_boot_enabled                                    = lookup(each.value, "secure_boot_enabled", null)
  vtpm_enabled                                           = lookup(each.value, "vtpm_enabled", null)
  user_data                                              = lookup(each.value, "user_data", null)
  zone                                                   = lookup(each.value, "zone", null)
  disk_controller_type                                   = lookup(each.value, "disk_controller_type", null)
  edge_zone                                              = lookup(each.value, "edge_zone", null)
  extensions_time_budget                                 = lookup(each.value, "extensions_time_budget", null)
  platform_fault_domain                                  = lookup(each.value, "platform_fault_domain", null)
  provision_vm_agent                                     = lookup(each.value, "provision_vm_agent", null)
  proximity_placement_group_id                           = lookup(each.value, "proximity_placement_group_id", null)
  source_image_id                                        = lookup(each.value, "source_image_id", null)
  os_managed_disk_id                                     = lookup(each.value, "os_managed_disk_id", null)
  virtual_machine_scale_set_id                           = lookup(each.value, "virtual_machine_scale_set_id", null)
  tags                                                   = lookup(each.value, "tags", null)

  # SSH Keys (dynamic block)
  dynamic "admin_ssh_key" {
    for_each = lookup(each.value, "admin_ssh_key", [])
    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key
    }
  }

  # Boot Diagnostics
  dynamic "boot_diagnostics" {
    for_each = lookup(each.value, "boot_diagnostics", null) == null ? [] : [each.value.boot_diagnostics]
    content {
      storage_account_uri = lookup(boot_diagnostics.value, "storage_account_uri", null)
    }
  }

  # Identity
  dynamic "identity" {
    for_each = lookup(each.value, "identity", null) == null ? [] : [each.value.identity]
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }

  # Plan
  dynamic "plan" {
    for_each = lookup(each.value, "plan", null) == null ? [] : [each.value.plan]
    content {
      name      = plan.value.name
      product   = plan.value.product
      publisher = plan.value.publisher
    }
  }

  # Additional Capabilities
  dynamic "additional_capabilities" {
    for_each = lookup(each.value, "additional_capabilities", null) == null ? [] : [each.value.additional_capabilities]
    content {
      ultra_ssd_enabled   = lookup(additional_capabilities.value, "ultra_ssd_enabled", null)
      hibernation_enabled = lookup(additional_capabilities.value, "hibernation_enabled", null)
    }
  }

  # Gallery Application
  dynamic "gallery_application" {
    for_each = lookup(each.value, "gallery_application", [])
    content {
      version_id                                  = gallery_application.value.version_id
      automatic_upgrade_enabled                   = lookup(gallery_application.value, "automatic_upgrade_enabled", null)
      configuration_blob_uri                      = lookup(gallery_application.value, "configuration_blob_uri", null)
      order                                       = lookup(gallery_application.value, "order", null)
      tag                                         = lookup(gallery_application.value, "tag", null)
      treat_failure_as_deployment_failure_enabled = lookup(gallery_application.value, "treat_failure_as_deployment_failure_enabled", null)
    }
  }

  # Secrets
  dynamic "secret" {
    for_each = lookup(each.value, "secret", [])
    content {
      key_vault_id = secret.value.key_vault_id
      dynamic "certificate" {
        for_each = secret.value.certificate
        content {
          url = certificate.value.url
        }
      }
    }
  }

  # Source Image Reference
  dynamic "source_image_reference" {
    for_each = lookup(each.value, "source_image_reference", null) == null ? [] : [each.value.source_image_reference]
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  # OS Image Notification
  dynamic "os_image_notification" {
    for_each = lookup(each.value, "os_image_notification", null) == null ? [] : [each.value.os_image_notification]
    content {
      timeout = lookup(os_image_notification.value, "timeout", null)
    }
  }

  # Termination Notification
  dynamic "termination_notification" {
    for_each = lookup(each.value, "termination_notification", null) == null ? [] : [each.value.termination_notification]
    content {
      enabled = termination_notification.value.enabled
      timeout = lookup(termination_notification.value, "timeout", null)
    }
  }
}
