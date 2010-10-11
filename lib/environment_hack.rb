class EnvironmentHack

  def self.para
    yield EnvironmentHack.new
  end
  
  def producao(&block)
    if RAILS_ENV=='production'
      block.call unless block.nil?
    end
  end
  
  def outros(&block)
    unless RAILS_ENV=='production'
      block.call unless block.nil?
    end
  end  
end
