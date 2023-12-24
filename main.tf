data "aws_ami" "amazon-linux-2023" {
    owners = [ "amazon" ]
    most_recent = true

    filter {
      name = "root-device-type"
      values = [ "ebs" ]
    }

    filter {
      name = "virtualization"
      values = [ "hvm" ]
    }

    filter {
      name = "architecture"
      values = ["x86_64"]
    }
    filter {
      name = "owner-alias"
      values = [ "amazon" ]

    }

    filter {
      name = "name"
      values = [ "al2023-ami-2023*" ]
    }
}

resource "aws_instance" "tf-myec2" {
    ami = data.aws_ami.amazon-linux-2023.id  
    instance_type = var.instance_type
    key_name = var.key_name
    count = var.num_of_instance
    vpc_security_group_ids = [aws_security_group.tf-sec-gr  ]
    user_data = templatefile("${abspath(path.module)}/userdata.sh", {myserver = var.server-name})
    #user_data = templatefile("userdata.sh", {myserver = var.server-name}) module kullanmasaydık böyle yapardık. 
    tags = {
      Name = var.tag
    }
  
}
resource "aws_security_group" "tf-sec-gr" {
    name = "${var.tag}-terraform-sec-gr"
    tags = {
      Name = var.tag
    }
    dynamic "ingress" {   # tekrar eden bloğu yapıyor. dynamic ( tekrar eden "ingress" olduğu için bunu yapıyoruz.)
      for_each = var.docket-instance-port
      iterator = port
      content {
        from_port = port.value 
        to_port = port.value
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]

     }
    }
    egress = {
        from_port = 0
        protocol = -1
        to_port = 0
        cidr_blocks = [ "0.0.0.0/0" ]
    }
}