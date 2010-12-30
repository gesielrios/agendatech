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
  
  def meses_com_total_de_eventos
    meses = Evento.agrupado_por_mes
    meses.default = 0    
    total = meses.values.inject(0){|soma,por_mes| soma += por_mes}    
    return meses,total
  end  

  def user_pic_by comentario    
    user = User.where(:nickname => comentario.twitter).first
    image = user.image
    extension = user.image[image.length-3, image.length]
    "twimages/#{comentario.twitter}.#{extension}"
  end
end
