variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
  type = string
}

variable "num_of_instance" {
    type = string
    default = 1  
}

variable "tag" {
    type = string
    default = "Docker-Instance"
}

variable "server-name" {
    type = string
    default = "docker-instance"
}

variable "docket-instance-port" {
    type = list(number)
    description = "docker-instance-sec-gr-inbound-rules"
    default = [ 22,80,8080 ]
}