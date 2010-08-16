#language: pt
Funcionalidade: Adiminstrar os novos eventos cadastrados pelo site

Contexto:
	Dado que o evento abaixo existe:
	|nome  |site  		       |descricao       |aprovado|estado|
	|gurusp|http://www.guru.com|encontro do guru|false   |SP    |
	Dado que estou na pagina administrativa


Cenario: Aprovar evento
	Quando clico no link "Aprovar"
	Entao deveria ver o "Evento aprovado." na lista de eventos

Cenario: Remover evento
	Quando clico no link "Remover"
	Entao deveria ver o "Evento removido." na lista de eventos

