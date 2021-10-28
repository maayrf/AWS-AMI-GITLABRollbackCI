resource "random_string" "rand6" {
  length = 6
  special = false
}

variable "nome_projeto" {
    description = "Nome do projeto para ser utilizado na URL"
    type = string
    default = "abc123"
}

variable "versao_projeto" {
    description = "Versao do projeto"
    type = string
    default = "0.0"
}

variable "app_level" {
    description = "Qual nivel a aplicacao vai ser colocada em producao. Atributos: app_n1, app_n2_{borda, autorizacoes, capturas, base}"
    type = string
    default = "app_n1"
}

variable "env_deploy" {
    description = "Ambiente destinado ao deploy"
    type = string
    default = "production"
}

variable "iam_role_policy" {
    description = "Se necessario, json completo da IAM Role Policy para atachar a IAM Role da EC2"
    type = string
    default = ""
}

variable "ec2_sg" {
    description = "ID da Security Group a ser atachada a EC2"
    type = string
}
variable "shutdown_at_night" {
  description = "Variavel booleana que define se o servidor do projeto pode ser desligado a noite"
  type = bool
  default = false
}
variable "bool_publico" {
    description = "Variavel booleana para verificar se o projeto recebera acesso publico pela url URL.com.br"
    type = bool
    default = false
}

variable "bool_privado" {
    description = "Variavel booleana para verificar se o projeto recebera acesso interno pela url URL.com.br"
    type = bool
    default = false
}

variable "bool_privado_interno" {
    description = "Variavel booleana para verificar se o projeto recebera acesso interno pela url interno.URL.com.br"
    type = bool
    default = false
}

variable "ebs_optimized" {
    description = "Habilitar EBS Otimizado. Nao funciona para instancias do tipo t2 e t3"
    type = bool
    default = false
}

variable "nlb_healthcheck_port" {
    description = "Porta de healthcheck do NLB"
    type = number
    default = 3000
}

variable "deregistration_delay" {
    description = "Tempo para remocao de backends do target group (draining)"
    type = number
    default = 60
}

variable "source_ami" {
    description = "ID da AMI utilizada como matriz"
    type = string
    default = "ami-XXXXXXXXXXX"
}

variable "instance_type" {
    description = "Tipo de instancia EC2 a ser utilizada"
    type = string
    default = "t2.micro"
}

variable "instance_family" {
  type = list(object({
    instance_type = string
    weighted_capacity = string
  }))
  default = [{
      instance_type = "t2.small"
      weighted_capacity = "2"
    }]
}


variable "key_name" {
    description = "Nome da chave usada na instancia"
    type = string
    default = ""
}

variable "max_size" {
  description = "Tamanho maximo do auto scale group"
  type        = string
}

variable "min_size" {
  description = "Tamanho minimo do auto scale group"
  type        = string
}

variable "desired_capacity" {
  description = "Quantidade de instances que deve ficar em execucao no auto scale group"
  type        = string
  default = 1
}

variable "default_cooldown" {
  description = "Quantos segundos o ASG deve aguardar entre cada escalabilidade"
  type        = number
  default = 300
}

variable "on_demand_percentage_above_base_capacity" {
  description = "Quantos porcento dos backends devem rodar como On-Demand"
  type        = number
  default = 100
}

variable "ec2_root_volume_size" {
  description = "Quantos Gigabytes o disco da instancia deve ter"
  type        = number
  default = 10
}

variable "porta_projeto" {
  description = "Numero da porta ao qual o servidor web do projeto estara escutando"
  type = number
  default = 80
}

variable "protocolo_projeto" {
  description = "Protocolo de comunicacao ao qual o servidor web do projeto estara configurado"
  type = string
  default = "HTTP"
}

variable "rota_teste_projeto" {
  description = "Rota web no projeto ao qual o Load Balancer utilizara para testar se a aplicacao esta funcionando corretamente"
  type = string
  default = "/index.html"
}


/*


variable "security_group" {
    description = "ID da Security Group utilizada"
    type = string
}

variable "subnet_ids" {
    description = "IDs das subnets utilizadas para subir os recursos"
    type = list(string)
    default = []
}

*/

