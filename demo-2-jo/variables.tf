
variable "AWS_REGION" {
    default     = "us-east-2"
}

variable "instance_type" {
    description = "AWS instance"
    default     = "t2.micro"
}
variable "AMIS" {
    type    = "map"
    default = {
        "us-east-2" = "ami-0c55b159cbfafe1f0"
    }
}

variable "PATH_TO_PRIVATE_KEY" {
    default = "demo2key"
}

variable "PATH_TO_PUBLIC_KEY" {
    default = "demo2key.pub"
}

variable "INSTANCE_USERNAME" {
    default = "ubuntu"
}