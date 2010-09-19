#language: pt
Funcionalidade: Controlar o acesso de administradores no site

    Contexto:
        Dado que estou na pagina administrativa
        E que o administrador abaixo esta cadastrado:
            |email           | password      |
            |admin@admin.com | adminspassword|

    Cenario: Bloquear usuários não registrados
        Entao deveria ver a página de login
				E nao deveria ver a aba "Logout"
				E nao deveria ver a aba "Aprovação Eventos"
				E nao deveria ver a aba "Aprovação Grupos"

    Cenario: Fazer logout da minha conta de administrador
        Quando preencho o campo "Email" com "admin@admin.com"
        E preencho o campo "Password" com "adminspassword"
        E clico no botao "Sign in"
        E clico no link "Logout"
        E estou na pagina administrativa
        Entao deveria ver a página de login

    Esquema do Cenario: Login com sucesso/Login inválido
        Dado que o administrador abaixo esta cadastrado:
            |email           | password      |
            |admin@admin.com | adminspassword|

        Quando preencho o campo "Email" com "<email>"
        E preencho o campo "Password" com "<pass>"
        E clico no botao "Sign in"
        Entao deveria ver "<msg>" na pagina

        Exemplos:
            | email            |pass          | msg    |
            |admin@admin.com   |adminspassword| Logout |
            |invalid@email.com |xxxxx         | Login  |



    Cenario: Entrar como usuário administrador
        Quando preencho o campo "Email" com "admin@admin.com"
        E preencho o campo "Password" com "adminspassword"
        E clico no botao "Sign in"
        Entao deveria ver a aba "Aprovação Eventos" 
        E deveria ver a aba "Aprovação Grupos" 
        E deveria ver a aba "Logout"

