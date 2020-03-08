resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.example.private_ip} >> private_ips.txt"
  }
}

output "ip" {
  value = aws_instance.example.public_ip
}

terraform {
  backend "s3" {
    bucket         = "tf-udemy-jo-20200308"
    key            = "gobal/demo4/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "tf-udemy-jo-state-locks"
    encrypt      = true
  }
}