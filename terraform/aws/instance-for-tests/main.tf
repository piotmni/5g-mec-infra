# Create an SSH key pair
resource "aws_key_pair" "piotr_ssh_key" {
  key_name   = "piotr"  # Replace with your key name
  public_key = file("../../../ansible/files/ssh_keys/piotr.pub")  # Replace with the path to your public key file
}

# Create an gnb
resource "aws_instance" "gnb" {
#  ami           = "ami-0a6e38961e6e621b0"  # Ubuntu 20.04 LTS (adjust the AMI as needed)
  ami           = ""  # Ubuntu 20.04 LTS ueransim preinstalled
  instance_type = "m7i.xlarge"  # Adjust the instance type as needed
  key_name      = aws_key_pair.piotr_ssh_key.key_name
  associate_public_ip_address = true

#  security_groups = [aws_security_group.allow_ssh.name]
  security_groups = [""]
  subnet_id = "" # public subnet a

  tags = {
    Name = "gnb"
  }
}

#output all public and private address
output "gnb_public_ip" {
  value = aws_instance.gnb.public_ip
}
output "gnb_private_ip" {
  value = aws_instance.gnb.private_ip
}

# Instll wireguard
# install docker
# configure wireguard
# download ueransim image
# prepare config
# start
