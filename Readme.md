ssh-keygen

id_rsa.pub will share accross all ec2 machines

id_rsa (private key to comminucalte slaves)
chmod 400 private_key
cd /etc/ansible

vi hosts
10.0.1.157 ansible_ssh_private_key_file=/home/ec2-user/ansible-terraform

