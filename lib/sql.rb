#manguezinho para pegar funcao do mysql ou do postgree, enquanto nao rola uma decisao sobre trocar ou nao.
class SQL
  def self.mes_do_evento
    EnvironmentHack.para_producao {
      "date_part('month',data)"
    }
    EnvironmentHack.para_os_outros{    
      "month(data)"      
    }
  end

end
