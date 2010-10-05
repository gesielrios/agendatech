RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.i18n.default_locale = :'pt-BR'
end

ValidatesTimeliness::Formats.remove_us_formats

#manguezinho para pegar funcao do mysql ou do postgree, enquanto nao rola uma decisao sobre trocar ou nao.
class SQL
  def self.mes_do_evento
    if(RAILS_ENV=='test' || RAILS_ENV=='development')
      "month(data)"      
    else
      "date_part('month',data)"
    end
  end
  
  def self.random
    if(RAILS_ENV=='test' || RAILS_ENV=='development')
      "rand()"      
    else
      "random()"
    end
  end  
end

