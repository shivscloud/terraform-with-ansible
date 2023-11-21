#!/bin/bash

# Function to install Ansible on Ubuntu/Debian
install_ansible_ubuntu() {
    sudo apt update
    sudo apt install -y ansible
}

# Function to install Ansible on CentOS/RHEL/Amazon Linux
install_ansible_redhat() {
    sudo yum install -y epel-release
    sudo yum install -y ansible
}

install_ansible_amz() {
    echo "Installing epel packaging"
    sudo sudo amazon-linux-extras install ansible2 -y
    sudo yum install ansible --enablerepo=epel
}

# Function to install Ansible on macOS using Homebrew
install_ansible_macos() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install ansible
}

# Check the operating system
os=$(uname -s)

# Install Ansible based on the operating system
case "$os" in
    Linux*) 
        if [ -f /etc/os-release ]; then
            source /etc/os-release
            case "$ID" in
                ubuntu|debian)
                    install_ansible_ubuntu
                    ;;
                centos|rhel)
                    install_ansible_redhat
                    ;;
                amzn)
                    install_ansible_amz
                    ;;    
                *)
                    echo "Unsupported Linux distribution: $ID"
                    exit 1
                    ;;
            esac
        else
            echo "Unable to determine Linux distribution."
            exit 1
        fi
        ;;
    Darwin*)
        install_ansible_macos
        ;;
    *)
        echo "Unsupported operating system: $os"
        exit 1
        ;;
esac

# Verify Ansible installation
ansible --version
