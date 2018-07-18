output "public_ip" {
  value = "${aws_instance.manager.public_ip}"
}

output "id_list" {
  value = ["${aws_instance.manager.*.id}"]
}
