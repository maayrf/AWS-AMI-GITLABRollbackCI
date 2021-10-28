#-----------
# Projeto
#-----------
env_deploy            = "testing"
nome_projeto          = ""
versao_projeto        = ""
porta_projeto         = "3000"
rota_teste_projeto    = "/index.html"
app_level             = "app_n1"
//ec2_sg                = "sg-f8357184"
bool_publico          = false //nome_projeto.URL.com.br em ELB publico
bool_privado          = false //nome_projeto.URL.com.br em ELB privado
bool_privado_interno  = true //nome_projeto.URL.com.br em ELB privado
deregistration_delay  = 60
source_ami            = "ami-XXXXXXXX" // Amazon Linux us-west-2: ami-XXXXXXXX
instance_type         = "t2.micro"
ebs_optimized         = false // Tipos de instancia t nao eh possivel ebs otimizado
key_name              = "infra"
ec2_root_volume_size  = 12
default_cooldown      = 120 //Quantos segundos o ASG deve aguardar entre cada escalabilidade
min_size              = 1
max_size              = 20
desired_capacity      = 1
shutdown_at_night     = true
on_demand_percentage_above_base_capacity = 0
