#language: pt
Funcionalidade: Mapear os grupos de usuarios do Brasil.

@grupo
Esquema do Cenario: Cadastro de grupo
	Dado que estou na pagina "cadastrar grupo"
	E que o grupo com nome "GURU-SP" esta cadastrado
	Quando preencho o campo "Nome" com "<nome>"
	Quando preencho o campo "Site" com "<site>"	
	E clico no botao "Cadastrar"
	Entao deveria ver o "<mensagem>" na lista

	Exemplos:
		|nome   | mensagem                      | site        |
		|GURU-SP| já existe                     | guru-sp.com |
		|GUJ    | Grupo registrado com sucesso. | guj.com.br  |
		|       | Campo obrigatório             |             |

Cenario: Lista de grupos
  Dado que o grupo abaixo existe:
    |nome | aprovado|
    |guru | true    |
    |bla  | false   |
  Dado que estou na pagina "lista de grupos"
  Entao deveria ver o "guru" na lista
  E não deveria ver o "bla" na lista

Cenario: Lista de eventos do grupo
  Dado que o grupo com nome "GURU-SP" esta cadastrado
  E que o grupo "GURU-SP" possui o evento "I Encontro"
  E que o grupo "GURU-SP" possui o evento "II Encontro"
  E que estou na pagina "lista de grupos"
  Quando clico no link "GURU-SP"
  Entao deveria ver o "I Encontro" na lista
  E deveria ver o "II Encontro" na lista
