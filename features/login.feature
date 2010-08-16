#language: pt
Funcionalidade: Controlar o acesso de administradores no site

Contexto:
    Dado que estou na pagina administrativa
    E que o administrador abaixo esta cadastrado:
    |email           | password      |
    |admin@admin.com | adminspassword|

Cenario: Bloquear usuários não registrados
    Entao deveria ver a página de login

Cenario: Entrar como usuário administrador
    Quando preencho o campo "Email" com "admin@admin.com"
    E preencho o campo "Password" com "adminspassword"
    E clico no botao "Sign in"
    Entao deveria ver "Eventos para aprovar" na pagina

Cenario: Fazer logout da minha conta de administrador
    Quando preencho o campo "Email" com "admin@admin.com"
    E preencho o campo "Password" com "adminspassword"
    E clico no botao "Sign in"
    E clico no link "Logout"
    E estou na pagina administrativa
    Entao deveria ver a página de login
