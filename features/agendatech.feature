#language: pt
Funcionalidade: Mapear os eventos de tecnologia do Brasil.

Esquema do Cenario: Cadastro de evento
	Dado que estou na pagina inicial
	Quando clico no link "Cadastre o seu"
	E preencho o campo nome com "<nome>"
	E preencho o campo site com "<site>"
    E preencho o campo data com "<data>"
	E preencho o campo descricao com "<descricao>"
	Quando clico no botao "Cadastrar"
	Entao deveria ver o "<mensagem>" na lista
	
	Exemplos:
	|nome|site                  |data          |descricao                 |mensagem|
	|QCon|http://www.qcon.com.br|11/09/2010    |evento mais legal         |Obrigado! Seu evento aparecerá na lista em instantes!|
	|    |                      |              |                          |Campo obrigatório|

Cenario: Busca por mes
	Dado que o evento abaixo existe:
	|nome  |site  		       |descricao       |aprovado|
	|gurusp|http://www.guru.com|encontro do guru|true   |	
	Dado que estou na pagina inicial		
	Quando clico no mes do evento
	Entao deveria ver o "gurusp" na lista
	
Cenario: Busca por estado
	Dado que o evento abaixo existe:
	|nome  |site  		       |descricao       |aprovado|estado|
	|gurusp|http://www.guru.com|encontro do guru|true    |SP	|
	Dado que estou na pagina inicial		
	Quando clico no estado do evento
	Entao deveria ver o "gurusp" na lista 	 
