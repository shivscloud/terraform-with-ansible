
resource "aws_key_pair" "ansible_keypair" {
  key_name   = "ansible-terraform"
  public_key = file("C:/Users/shiva/.ssh/id_rsa.pub") # Path to your public key file
}

resource "aws_instance" "master_ec2_instance" {
  depends_on = [aws_key_pair.ansible_keypair]  
  ami                    = var.ami_id  # Replace with the desired AMI ID
  instance_type = "t2.micro"  # Replace with the desired instance type
  subnet_id              = var.subnet_ids[0]  # Choose the desired subnet ID
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_group_ids[0]]
  key_name = "ansible-terraform"
  tags = {
    Name = "master-instance"
  }
#   user_data = <<-EOF
#               #!/bin/bash
#               sudo yum update -y
#               sudo yum install -y epel-release
#               sudo yum install -y ansible
#               EOF
#   provisioner "file" {
#     source      = "D:\\Cloud-DevOps\\Ansible\\ansible.sh"
#     destination = "/home/ec2-user/work.sh"
#       connection {
#         type ="ssh"
#         user = "ec2-user"
#         private_key = file("D:\\Cloud-DevOps\\Ansible\\ansible.pem")
#         host = self.public_ip
#     }
#   }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/shiva/.ssh/id_rsa")
    host        = self.public_ip
  }  
#   provisioner "remote-exec" {
#     connection {
#       type ="ssh"
#       user = "ec2-user"
#       private_key = file("D:\\Cloud-DevOps\\Ansible\\ansible.pem")
#       host        = self.network_interface[0].access_config[0].allocated_ip_address
#     }
#     inline = [
#       "sudo yum update -y"  
#     ]
#   }
  provisioner "file" {
    source      = "D:\\Cloud-DevOps\\Ansible\\ansible.sh"      # terraform machine
    destination = "/home/ec2-user/work.sh" # remote machine
  }

  provisioner "file" {
    source      = "C:/Users/shiva/.ssh/id_rsa"      # terraform machine
    destination = "/home/ec2-user/ansible" # remote machine
  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/work.sh",  # Ensure the script is executable
      "/home/ec2-user/work.sh",           # Run the script
      "chmod 400 /home/ec2-user/ansible"
    ]
  }
  # provisioner "file" {
  #   source      = "D:\\Cloud-DevOps\\Ansible\\hosts"      # terraform machine
  #   destination = "/etc/ansible/" # remote machine
  # }
  # provisioner "local-exec" {
  #   command = <<-EOT
  #     ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa -N ""
  #   EOT
  # }
} 

resource "aws_instance" "slave_ec2_instance" {
  depends_on = [aws_instance.master_ec2_instance]  
  ami                    = var.ami_id  # Replace with the desired AMI ID
  instance_type = "t2.micro"  # Replace with the desired instance type
  subnet_id              = var.subnet_ids[0]  # Choose the desired subnet ID
  # associate_public_ip_address = true
  vpc_security_group_ids = [var.security_group_ids[0]]
  key_name = "ansible-terraform"
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/Users/shiva/.ssh/id_rsa")
    host        = self.public_ip
  }  
  # provisioner "file" {
  #   source      = "D:\\Cloud-DevOps\\Ansible\\ansible.sh"      # terraform machine
  #   destination = "/home/ec2-user/work.sh" # remote machine
  # }
  
  # provisioner "remote-exec" {
  #   inline = [
  #     "chmod +x /home/ec2-user/work.sh",  # Ensure the script is executable
  #     "/home/ec2-user/work.sh",           # Run the script
  #   ]
  # }
  # user_data = <<-EOF
  #   #!/bin/bash
  #   mkdir -p /home/ec2-user/.ssh
  #   echo "${aws_instance.master_ec2_instance.public_ip} $(cat /home/ec2-user/.ssh/id_rsa.pub)" >> /home/ec2-user/.ssh/authorized_keys
  #   chmod 700 /home/ec2-user/.ssh
  #   chmod 600 /home/ec2-user/.ssh/authorized_keys
  #   chown -R ec2-user: /home/ec2-user/.ssh
  #   EOF
}