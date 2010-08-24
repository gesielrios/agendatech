#language: pt
Funcionalidade: Fornecer RSS dos eventos cadastrados

@rss
Cenario: Feeds
Dado que o evento abaixo existe:
|nome  |site  		       |descricao       |aprovado|estado|
|gurusp|http://www.guru.com|encontro do guru|true    |SP|	
Dado que estou na pagina inicial		
Quando clico no mes do evento
Entao deveria ver o "gurusp" na lista 	 	 			 	 	 		

