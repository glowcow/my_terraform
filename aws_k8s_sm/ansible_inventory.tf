 resource "local_file" "ansible_inventory" {
  content = templatefile("ansible_inventory.tftpl",
    {
     hostnames = [for i in aws_instance.k8s-master-aws.*.tags : i.Name],
     addreses = aws_instance.k8s-master-aws.*.public_ip
    }
  )
  filename = "ansible/inventory.ini"
}