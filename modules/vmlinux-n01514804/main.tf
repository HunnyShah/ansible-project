resource "azurerm_availability_set" "linux_avset" {
  name                = var.availability_set_name
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count = 2
}

resource "azurerm_public_ip" "linux_pip" {
  for_each            = var.vm_names
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "${each.key}-dns"
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.vm_names
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = try(azurerm_public_ip.linux_pip[each.key].id, null)
  }
}

resource "azurerm_virtual_machine" "linux_vm" {
  for_each            = var.vm_names
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  availability_set_id = azurerm_availability_set.linux_avset.id
  network_interface_ids = [azurerm_network_interface.linux_nic[each.key].id]
  vm_size             = "Standard_B1ms"
  
  tags = var.tags

  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${each.key}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = each.key
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
  disable_password_authentication = true
  ssh_keys {
    path     = "/home/${var.admin_username}/.ssh/authorized_keys"
    key_data = file("~/.ssh/id_rsa.pub") # <-- Make sure this file exists!
  }
}

  boot_diagnostics {
    enabled      = true
  storage_uri  = var.boot_diagnostics_storage_uri
  }

  provisioner "remote-exec" {
    inline = ["echo $(hostname)"]
    connection {
      type     = "ssh"
      user     = var.admin_username
      private_key = file("~/.ssh/id_rsa")
      host     = azurerm_public_ip.linux_pip[each.key].ip_address
    }
  }
}

