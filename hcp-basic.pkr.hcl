packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.1-dev"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "example-west" {
  region = "use-west-2"

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "ubuntu/images/*ubuntu-xenial-16.04-amd64-server-*"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }

  instance_type  = "t2.small"
  ssh_username   = "ubuntu"
  ssh_agent_auth = false
  ami_name       = "packer_AWS_{{timestamp}}"
}

build {
  hcp_packer_registry {
    slug        = "test-example-west"
    description = <<EOT
This is a description for the example HCP Packer bucket.
    EOT

    labels = {
      "version" : "0.0.1",
      "team" : "me"
    }
  }

  sources = [
    "source.amazon-ebs.example-west"
  ]
}
