class Neo4j::Wrapper
  
  def initialize(host)
    @host = host
  end
  
  
  def create_node(false,properties={})
    Restfulie.at("#{@host}/node").accepts('application/json').as('application/json').post!(properties)
  end
  
  def index(node_id,key,value)
    # descobrir como indexa
  end  
  
  def create_relation(from_id,to_id,type,properties={})
    Restfulie.at("#{@host}/node/#{from_id}/relationships").accepts('application/json').as('application/json').post!(
    :to => "#{@host}/node/#{to_id}",:type => type,:data => properties)
  end
  
  def get_node(id)
    Restfulie.at("#{@host}/node/#{id}").accepts('application/json').get!
  end
  
end
