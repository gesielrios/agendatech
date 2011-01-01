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
    user = User.por_login_social(comentario.twitter)
    if user
       image = user.image
       extension = user.image[image.length-3, image.length]       
       nome_da_imagem = "#{comentario.twitter}.#{extension}"
       return link_da_imagem_do_twitter_para nome_da_imagem
    else
      "twitter_usr_padrao.png"              
    end
  end
  
  def link_da_imagem_do_twitter_para nome_da_imagem
     EnvironmentHack.para do |env|
       env.producao {
          return "http://s3.amazonaws.com/twitter_images/#{nome_da_imagem}"
       }
       env.outros {
          return "twimages/#{nome_da_imagem}"           
       } 
     end     
  end
  
end
