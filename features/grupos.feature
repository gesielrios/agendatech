#language: pt
Funcionalidade: Mapear os grupos de usuarios do Brasil.

Esquema do Cenario: Cadastro de grupo
	Dado que estou na pagina "grupos"
	E que o grupo com nome "GURU-SP" esta cadastrado
	Quando preencho o campo "Nome" com "<nome>"
	E clico no botao "Cadastrar"
	Entao deveria ver o "<mensagem>" na lista

	Exemplos:
		|nome   | mensagem                      |
		|GURU-SP| já existe                     |
		|GUJ    | Grupo registrado com sucesso. |
		|       | Campo obrigatório             |

