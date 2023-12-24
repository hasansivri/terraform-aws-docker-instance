output "instance_public_ip" {
    value = aws_instance.tf-myec2.*.public_ip
}

output "sec_gr_id" {
    value = aws_security_group.tf-sec-gr.id
}

output "instance_id" {
    value = aws_instance.tf-myec2.*.id
}

# "tf-myec2.*.id" : buralardaki "*" yıldızın amacı count olmasınddan dolayıdır.