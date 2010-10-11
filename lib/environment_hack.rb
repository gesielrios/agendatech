class EnvironmentHack
  
  def self.para_producao(&block)
    if RAILS_ENV=='production'
      block.call unless block.nil?
    end
  end
  
  def self.para_os_outros(&block)
    unless RAILS_ENV=='production'
      block.call unless block.nil?
    end
  end  
end
