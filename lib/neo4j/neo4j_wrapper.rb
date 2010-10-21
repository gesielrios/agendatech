class Neo4j::Neo4jWrapper
  
  def initialize(host)
    @host = host
  end
  
  def create_node(properties={})
    Restfulie.at("#{@host}/node").accepts('application/json').as('application/json').post!(properties)
  end
  
  def nodes
  end
  
  def create_relation(properties={})
    
  end
  
  def relations
    []
  end
  
  
end
