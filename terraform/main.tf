provider "aws" {
  region = "${var.region}"
}

module "key_pair" {
  source       = "modules/key_pair"
  key_name     = "${var.key_name}"
  pub_key_path = "${var.pub_key_path}"
}

module "base_linux" {
  source = "modules/base"
  env    = "${var.env}"
}

module "s3" {
  source	  = "modules/s3" 
}


module "manager" {
  ami              = "${data.aws_ami.image.id}"
  source           = "modules/manager"
  pub_key_path     = "${var.pub_key_path}"
  ssh_user         = "${var.ssh_user}"
  private_key_path = "${var.private_key_path}"
  env              = "${var.env}"
  key_name         = "${module.key_pair.key_name}"
  sg_ids           = "${module.base_linux.sg_id}"
  name             = "${var.manager_server_params["name"]}"
}

module "worker" {
  ami              = "${data.aws_ami.image.id}"
  source           = "modules/worker"
  pub_key_path     = "${var.pub_key_path}"
  ssh_user         = "${var.ssh_user}"
  private_key_path = "${var.private_key_path}"
  env              = "${var.env}"
  key_name         = "${module.key_pair.key_name}"
  sg_ids           = "${module.base_linux.sg_id}"
  name             = "${var.worker_server_params["name"]}"
  count            = "${var.worker_server_params["count"]}"
}


resource null_resource "manager" {
  depends_on = ["module.manager"]

  provisioner "local-exec" {
    command = "cd ../ansible && ansible-playbook playbooks/manager.yml"
  }
}

resource null_resource "worker" {
  depends_on = ["module.worker"]
  
  triggers = {
    cluster_instance_ids = "${join(",", module.worker.id_list)}"
  }

  provisioner "local-exec" {
    command = "cd ../ansible && ansible-playbook -e manager_ip=${module.manager.public_ip} playbooks/worker.yml"
  }
}

