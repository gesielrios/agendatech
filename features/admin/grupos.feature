#language: pt
@javascript
Funcionalidade: Adminstrar os novos grupos cadastrados pelo site

Contexto:
	Dado que o grupo abaixo existe:
	|nome  |aprovado|
    |gurusp|false |
  E que estou como administrador
  E que estou na pagina "administracao de grupos"
  

Cenario: Aprovar grupo
	Quando clico no link "Aprovar"
	Entao deveria ver "Grupo aprovado." na pagina

Cenario: Remover grupo
	Quando clico no link "Remover"
	Entao deveria ver "Grupo removido." na pagina

