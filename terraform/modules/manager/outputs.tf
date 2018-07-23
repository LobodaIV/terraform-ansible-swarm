output "public_ip" {
  value = "${join("",aws_instance.manager.*.public_ip)}"
}

output "id_list" {
  value = ["${aws_instance.manager.*.id}"]
}
