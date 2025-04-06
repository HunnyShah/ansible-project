resource "null_resource" "ansible_provisioner" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = <<EOT
      ANSIBLE_HOST_KEY_CHECKING=False \
      ansible-playbook -i ${path.module}/../../ansible/inventory \
      ${path.module}/../../ansible/n01514804-playbook.yml
    EOT
  }

  depends_on = [
    azurerm_virtual_machine.linux_vm["n01514804-vm1"],
    azurerm_virtual_machine.linux_vm["n01514804-vm2"]
  ]
}
