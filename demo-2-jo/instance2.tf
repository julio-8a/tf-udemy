#provider info
provider "aws" {
    profile = "default"
    region  = var.AWS_REGION
}

# Data source to pull AWS availability zones
data "aws_availability_zones" "all" {}

#Create ssh key pair
resource "aws_key_pair" "demo2key" {
    key_name   = "demo2key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Create AMI instance
resource "aws_instance" "demo2" {
    ami           = var.AMIS[var.AWS_REGION]
    instance_type = var.instance_type
    key_name      = aws_key_pair.demo2key.key_name

    tags = {
        Name = "udemy-demo2"
    }

    provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
}

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/script.sh",
            "sudo /tmp/script.sh",
        ]
    }

    connection {
        host        = coalesce(self.public_ip, self.private_ip)
        type        = "ssh"
        user        = var.INSTANCE_USERNAME
        private_key = file(var.PATH_TO_PRIVATE_KEY) 
    }    
}

