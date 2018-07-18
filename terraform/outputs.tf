output "manager" {
  value = ["${module.manager.public_ip}"]
}

output "worker" {
  value = ["${module.worker.public_ip}"]
}
