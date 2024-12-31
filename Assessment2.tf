provider "aws"{
    region = "ap-southeast-1"
    access_key = "-"
    secret_key = "-"
}


terraform{
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

resource "aws_security_group" "SyedSecGroup"{
    name = "default-vpc-security-group"
    description = "allow ssh and http access"

    ingress{
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow ssh from anywhere (cidr_blocks)"
    }

    ingress{
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow http from anywhere (cidr_blocks)"
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allow all outbound traffic"
    }

    tags = {
        Name = "DefaultVPCSecurityGroup"
    }
}

resource "aws_instance" "SyedEC2_1"{
    ami = "ami-06650ca7ed78ff6fa"
    instance_type = "t2.micro"
    key_name = "cfkey"
    vpc_security_group_ids = [aws_security_group.SyedSecGroup.id]
    ebs_block_device {
        device_name = "/dev/xvdf"
        volume_size = 10
        volume_type = "gp2"
    }
    tags = {
        Name = "Terraform-EC2-1"
    }

}

resource "aws_instance" "SyedEC2_2"{
    ami = "ami-06650ca7ed78ff6fa"
    instance_type = "t2.nano"
    key_name = "cfkey"
    vpc_security_group_ids = [aws_security_group.SyedSecGroup.id]
    ebs_block_device {
        device_name = "/dev/xvdf"
        volume_size = 10
        volume_type = "gp2"
    }
    tags = {
        Name = "Terraform-EC2-2"
    }

}