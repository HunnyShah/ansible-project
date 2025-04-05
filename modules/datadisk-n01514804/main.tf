resource "azurerm_managed_disk" "datadisk" {
  for_each            = var.vm_names
  name                = "${each.key}-datadisk"
  location            = var.location
  resource_group_name = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option      = "Empty"
  disk_size_gb       = 10
  tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attach" {
  for_each            = var.vm_names
  managed_disk_id     = azurerm_managed_disk.datadisk[each.key].id
  virtual_machine_id  = each.value
  lun                 = 0
  caching             = "ReadWrite"
}