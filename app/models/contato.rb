class Contato
  attr_accessor :nome, :email, :mensagem
  
  def initialize (hash)
    @nome = hash[:nome]
    @email = hash[:email]
    @mensagem = hash[:mensagem]
  end
end