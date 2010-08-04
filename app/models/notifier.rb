class Notifier < ActionMailer::Base

  def envia_email (contato)
    
    from "contato@agendatech.com.br"
    recipients ["andersonlfl@gmail.com", "alots.ssa@gmail.com.br"]
    subject "Contato agendatech"
    body :contato => contato
    
  end

end
