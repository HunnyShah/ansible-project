resource "azurerm_availability_set" "windows_avset" {
  name                = var.availability_set_name
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count = 2
}

resource "azurerm_public_ip" "windows_pip" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "winvm-${random_id.dns_id.hex}"
}
resource "random_id" "dns_id" {
  byte_length = 4
}

resource "azurerm_network_interface" "windows_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.windows_pip.id
  }
}

resource "azurerm_virtual_machine" "windows_vm" {
  count               = var.vm_count
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  availability_set_id = azurerm_availability_set.windows_avset.id
  network_interface_ids = [azurerm_network_interface.windows_nic.id]
  vm_size             = "Standard_B1ms"

  tags = var.tags

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = var.boot_diagnostics_storage_uri
  }
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  count               = var.vm_count
  name                = "${var.vm_name}-antimalware"
  virtual_machine_id  = azurerm_virtual_machine.windows_vm[count.index].id
  publisher           = "Microsoft.Azure.Security"
  type                = "IaaSAntimalware"
  type_handler_version = "1.5"
}

