# AWS-AMI-GITLABRollbackCI
Fazer rollback manualmente via Postman de uma determinada versão de AWS EC2 AMI, sem que essa versão passe pelo stage de build novamente.
.
.
.
Instruções Gerais
Edite os arquivos abaixo, inserindo as informações necessárias e/ou ajustando scripts para que o deploy da aplicação ocorra.
.gitlab-ci.yml: Insira o nome do projetom, a versão do node e a URL para fazer o clone. Observe que a URL precisa ser acessível sem chaves. Para isso, gerar um Deploy Token.
terraform/main.tf: Alterar o "key" do "backend s3", inserindo o caminho no S3 o local para se guardar o state do projeto.
terraform/app.tf: Preencher as tags do "data" que busca a security group criada para o projeto
packer/configs/bootstrap-projeto.sh: Arquivo destinado ao bootstrap do projeto. Neste arquivo que são executadas as manobras necessárias para que o projeto entre em funcionamento.
Definir configurações do projeto: 
Acessar Settings -> CI/CD -> General pipelines e desmarcar as opções abaixo:


Auto-cancel redundant, pending pipelines


Skip outdated deployment jobs



Observações projeto node 14

Caso o projeto a ser deployado seja um dos novos projetos em node 14, algumas novas configurações devem ser realizadas nos seguintes arquivos:


.gitlab-ci.yml: Modifique a versão do Node para v14 (sem major nem minor, para permitir que novas versões sejam utilizadas automaticamente)


packer/configs/bootstrap-projeto.sh: Substituir a execução do script build.sh na pasta scripts pela execução do comando npm run build na pasta ~/project/build/


packer/configs/pm2.json: Configurar a variável de ambiente NODE_ENV com o valor production e adicionar a variável APP_ENV com o valor VAR_ENVIRONMENT que receberá o ambiente propriamente dito do processo de build.
