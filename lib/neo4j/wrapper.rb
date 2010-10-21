class Neo4j::Wrapper
  
  def initialize(host)
    @host = host
  end
  
  
  def create_node(properties={})
    Restfulie.at("#{@host}/node").accepts('application/json').as('application/json').post!(properties)
  end
  
  def create_relation(relation_uri,to_uri,type,properties={})
    Restfulie.at(relation_uri).accepts('application/json').as('application/json').post!(
    :to => to_uri,:type => type,:data => properties)
  end
  
  def find_node(uri)  
    Restfulie.at(uri).accepts('application/json').get!
  end
  
end
