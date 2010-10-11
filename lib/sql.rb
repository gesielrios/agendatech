#manguezinho para pegar funcao do mysql ou do postgree, enquanto nao rola uma decisao sobre trocar ou nao.
class SQL
  def self.mes_do_evento
    EnvironmentHack.para do |env| 
      env.producao {
        "date_part('month',data)"
      }
      env.outros {   
        "month(data)"      
      }
    end
  end

end
