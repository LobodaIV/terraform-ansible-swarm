output "public_ip" {
  value = ["${aws_instance.worker.*.public_ip}"]
}

output "id_list" {
  value = ["${aws_instance.worker.*.id}"]
}
