class EnvironmentHack

  def self.para
    yield EnvironmentHack.new
  end
  
  def producao(&block)
    if Rails.env=='production'
      block.call unless block.nil?
    end
  end
  
  def outros(&block)
    unless Rails.env=='production'
      block.call unless block.nil?
    end
  end  
end
