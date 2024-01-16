output "windows_vm_object" {
  value = { for k, v in azurerm_windows_virtual_machine.windows_vm : k => v.id }
}
