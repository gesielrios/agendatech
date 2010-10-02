# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :tag_cloud, :twitter_search
  helper_method :meses, :numero_do_mes, :estados, :nome_do_estado

  protected
  def meses
    {
      "Janeiro" => 1,
      "Fevereiro" => 2,
      "Março" => 3,
      "Abril" => 4,
      "Maio" => 5,
      "Junho" => 6,
      "Julho" => 7,
      "Agosto" => 8,
      "Setembro" => 9,
      "Outubro" => 10,
      "Novembro" => 11,
      "Dezembro" => 12
    }
  end

  def numero_do_mes (mes)
    meses[mes]
  end

  def estados
    {
    "AC" =>   "Acre"  ,
    "AL" =>   "Alagoas"  ,
    "AP" =>    "Amapá"  ,
    "AM" =>    "Amazonas"  ,
    "BA" =>   "Bahia"  ,
    "CE" =>    "Ceará"  ,
    "DF" =>    "Distrito Federal"  ,
    "GO" =>    "Goiás"  ,
    "ES" =>   "Espírito Santo"  ,
    "MA" =>    "Maranhão"  ,
    "MT" =>   "Mato Grosso"  ,
    "MS" =>    "Mato Grosso do Sul"  ,
    "MG" =>   "Minas Gerais"  ,
    "PA" =>    "Pará"  ,
    "PB" =>   "Paraiba"  ,
    "PR" =>    "Paraná"  ,
    "PE" =>    "Pernambuco"  ,
    "PI" =>    "Piauí"  ,
    "RJ" =>  "Rio de Janeiro"  ,
    "RN" =>   "Rio Grande do Norte"  ,
    "RS" =>    "Rio Grande do Sul"  ,
    "RO" =>   "Rondônia"  ,
    "RR" =>    "Rorâima"  ,
    "SP" =>   "São Paulo"  ,
    "SC" =>    "Santa Catarina"  ,
    "SE" =>   "Sergipe"  ,
    "TO" =>    "Tocantins"
    }
  end

  # waiting peaceful for my refactor...
  def nome_do_estado (sigla)
    estados[sigla]
  end


  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  private
  def tag_cloud
     @tags = Evento.tag_counts
  end

  def twitter_search    
    eventos = Evento.find_by_sql("select distinct twitter_hash from eventos where aprovado = true order by rand() limit 3")
    @twits = []

    eventos.each do |e|
       Twitter::Search.new(e.twitter_hash).page(1).per_page(1).each do |r|
         @twits << r
       end
    end
    @twits
  end


end

