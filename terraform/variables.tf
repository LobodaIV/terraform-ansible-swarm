variable pub_key_path {
  description = "Path to ssh public key used to create this key on AWS"
  default = "/root/.ssh/mykey.pub"
}

variable ssh_user {
  description = "User used to log in to instance"
  default     = "ubuntu"
}

variable private_key_path {
  description = "Path to the private key used to connect to instance"
  default = "/root/.ssh/mykey"
}

variable region {
  description = "Region"
  default     = "eu-central-1"
}

variable env {
  description = "Environment prefix"
  default = "dev"
}

variable manager_server_params {
  default = {
    "name"  = "manager"
  }
}

variable worker_server_params {
  default = {
    "name"  = "worker"
    "count" = "2"
  }
}

variable key_name {
  description = "name of ssh key to create"
  default = "mykey"
}
