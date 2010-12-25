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
  
  def estados_com_total_de_eventos
    estados = Evento.agrupado_por_estado    
    total = estados.values.inject(0){|soma,por_estado| soma += por_estado}    
    return estados,total
  end

end
