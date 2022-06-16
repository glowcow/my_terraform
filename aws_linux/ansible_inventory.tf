resource "local_file" "ansible_inventory" {
  content = templatefile("ansible_inventory.tftpl",
    {
     hostnames = [for i in aws_instance.linux-aws.*.tags : i.Name],
     addreses = aws_instance.linux-aws.*.public_ip
     user = var.ansible_user
    }
  )
  filename = "ansible/inventory.ini"
}