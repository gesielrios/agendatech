RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.i18n.default_locale = :'pt-BR'
end

ValidatesTimeliness::Formats.remove_us_formats

#manguezinho para pegar a funcao de mes em funcao do ambiente. Ta aqui justamente para ser temporario.
class SQL
  def self.mes_do_evento
    if(RAILS_ENV=='test' || RAILS_ENV=='development')
      "month(data)"      
    else
      "date_part('month',data)"
    end
  end
end

