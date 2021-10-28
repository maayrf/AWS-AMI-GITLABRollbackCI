module "webserver-module" {
  # Endereco do Modulo
  source                = "git::https://gitlab+deploy-token-*******.git?ref=master"
  env_deploy            = var.env_deploy
  nome_projeto          = var.nome_projeto
  app_level             = var.app_level
  porta_projeto         = var.porta_projeto
  rota_teste_projeto    = var.rota_teste_projeto
  ec2_sg                = data.aws_security_group.ec2_sg.id
  bool_publico          = var.bool_publico
  bool_privado          = var.bool_privado
  bool_privado_interno  = var.bool_privado_interno
  deregistration_delay  = var.deregistration_delay
  source_ami            = data.aws_ami.this.image_id
  instance_family       = var.instance_family
  ebs_optimized         = var.ebs_optimized
  key_name              = var.key_name
  ec2_root_volume_size  = var.ec2_root_volume_size
  default_cooldown      = var.default_cooldown
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  shutdown_at_night     = var.shutdown_at_night
  on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity
  iam_role_policy       = var.iam_role_policy
  nlb_healthcheck_port  = var.nlb_healthcheck_port
}


data "aws_security_group" "ec2_sg" {
  tags = {
      "terraform:nivel1:vpc:sg" = "ec2.instance-name"
  }
}
