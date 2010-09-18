#language: pt
Funcionalidade: Administrar os novos grupos cadastrados pelo site

Contexto:
	Dado que o grupo abaixo existe:
	|nome  |aprovado| site |
    |gurusp|false | www.guru-sp.com |
  E que estou como administrador
  E que estou na pagina "administracao de grupos"
  

Cenario: Aprovar grupo
	Quando clico no link "Aprovar"
	Entao deveria ver "Grupo aprovado." na pagina

Cenario: Remover grupo
	Quando clico no link "Reprovar"
	Entao deveria ver "Grupo reprovado." na pagina

