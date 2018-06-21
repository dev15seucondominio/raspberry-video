Sistema de ciclo de Anuncio de Imagens e Videos
Prerequisitos:
  -Inicialização do scrpit ao iniciar raspberry
  -Acesso a Banco postgres
  -Modelagem do Banco
  -Conectar-se via wifi por comandos
  -Configurar o f11 via comando
  -Resolução HD de vídeos
  -tamanho dos videos
  -quantidade de tempo de visualização de uma determinada imagem
  -dependencia de imagens
  -configuração de som geral
  -tempo de vida do video
  -pesquisar por auto-play
  -pegar as imagens do server
  -colocar docker
  -instalação de tudo o possível

Next Steps:
	-mostrar as imagems com o memsmo tempo de duração dos vídeos
	-relacionar os videos com as imagens para ter controle simultaneo de ambos
	-pensar em um modelo básico para obter os dados do condominio, como logo, telefone etc..

coisas a serem instaladas
sudo npm install -g coffee-script
sudo npm install -g node-env-file
sudo npm install -g request
sudo npm install -g express
sudo npm install -g moment
sudo npm install -g nodemon


https://elinux.org/RPiconfig#Video_mode_options
Modos de Resolução monitor:
Group CEA
  mode 1: 640x480 60Hz, 4:3 clock:25MHz progressive
  mode 2: 720x480 60Hz, 4:3 clock:27MHz progressive
  mode 3: 720x480 60Hz, 16:9 clock:27MHz progressive
  mode 4: 1280x720 60Hz, 16:9 clock:74MHz progressive
  mode 16: 1920x1080 60Hz, 16:9 clock:148MHz progressive


GROUP DMT
  mode 4: 640x480 60Hz, 4:3 clock:25MHz progressive
  mode 9: 800x600 60Hz, 4:3 clock:40MHz progressive
  mode 16: 1024x768 60Hz, 4:3 clock:65MHz progressive
  mode 81: 1366x768 60Hz, 16:9 clock:85MHz progressive

CLIENTE_ID=1; TV_ID=1; npm run config_tv
sudo bash -c 'echo -e "CLIENTE_ID=$CLIENTE_ID\nTV_ID=$TV_ID\n" > /etc/environment'; source /etc/environment
