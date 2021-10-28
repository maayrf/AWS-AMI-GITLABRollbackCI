provider "aws" {
  region  = "us-west-2"
}

data "aws_ami" "this" {
    most_recent      = true
  name_regex       = "amazonlinux2/services/${var.nome_projeto}/*"
  owners           = ["self"]

  filter {
    name   = "tag:app_name"
    values = ["${var.nome_projeto}"]
  }

  filter {
    name   = "tag:app_version"
    values = ["${var.versao_projeto}"]
  }
}

terraform {
  backend "s3" {
    bucket         = "bucket-name"
    key            = "directory-name/instance-name.tfstate"
    region         = "sa-east-1"
    dynamodb_table = "table-name"
  }
}
