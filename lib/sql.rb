#manguezinho para pegar funcao do mysql ou do postgree, enquanto nao rola uma decisao sobre trocar ou nao.
class SQL
  def self.mes_do_evento
    EnvironmentHack.para do |env| 
      env.producao {
        return "date_part('month',data)"
      }
      env.outros {   
        return "month(data)"      
      }
    end
  end

end
