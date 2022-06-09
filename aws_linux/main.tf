resource "aws_key_pair" "tf" {
  key_name   = "tf-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "linux-aws" {
  count = var.ec2_count
  ami = var.ami_image
  instance_type = var.instance_type
  associate_public_ip_address = true
  subnet_id = aws_subnet.private.id
  key_name = aws_key_pair.tf.key_name
  vpc_security_group_ids = [aws_security_group.linux-sg.id]
  tags = {
      Name = "${var.ec2_name}-${var.aws_region}-n${count.index}"
    }
}
