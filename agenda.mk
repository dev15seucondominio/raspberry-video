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
	-configurar a lista de repetiçaõ dos videos
	-pensar em um modelo básico para obter os dados do condominio, como logo, telefone etc..
	-manipular os videos para parar, continuar, adiantar e retroceder o video, pular para o próximo etc..


coffee server.coffee
ja ir testando a logica de negocio caso a quantiade de videos seja superior a
quantide de video a ser passado, este é resetado, o video fica no cach do
navegador logo ele não precisa realizar outra requisição para o obter os videos,
apenas atualiza a lista e a manda para o front o front fica por conta de
analizar a ordem dos videos e como tratar os casos quando o video ainda está
sendo reproduzido com tudo todos os videos devem ser apresentados depois de
realizar testes com os videos, começar a trabalhar com imagems e videos para
sincronizar os mesmos a fins de evitar dores de cabeça em um futuro próximo

