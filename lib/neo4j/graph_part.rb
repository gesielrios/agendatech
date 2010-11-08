module Neo4j::GraphPart
  
  def uri
    @properties.self
  end  
  
  def method_missing(name,*args)      
    property_to_be_founded = name.to_s    
    if @properties.has_key?(property_to_be_founded.gsub('_',' '))
      return @properties[property_to_be_founded]
    else
      if(@properties.data.has_key?(property_to_be_founded))
        return @properties.data[property_to_be_founded]
      else
        raise "Não existe a propriedade de nome #{name}"     
      end
    end
  end        

  private 
    def properties=(properties)        
      @properties = properties
    end  
end
