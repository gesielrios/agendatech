module EventosHelper
  def evento_do (grupo)
    grupo ? "Evento do #{grupo.nome}" : ""
  end

  def evento_full_path(evento)
    evento_path(:ano => evento.data.year,:id=>evento)
  end
  
  def evento_full_url(evento)
    evento_url(:ano => evento.data.year,:id=>evento)
  end


end
