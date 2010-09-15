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

