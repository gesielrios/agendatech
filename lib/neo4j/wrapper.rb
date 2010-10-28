class Neo4j::Wrapper
  
  def initialize(host)
    @host = host
  end
  
  
  def create_node(properties={})
    Restfulie.at("#{@host}/node").accepts('application/json').as('application/json').post!(properties)
  end
  
  def index(node_id,key,value)
      uri = URI.parse(@host)      
      response = Net::HTTP.start(uri.host,uri.port){ |req|
                    req.post("/index/node/#{key}/#{value}","#{@host}/node/#{node_id}",{'Content-Type' => 'text/plain'})
                 }
      raise "Não foi possivel adicionar o nó no indice com as propriedades. Código de retorno => #{response.code}" unless response.code == 201               
  end  
  
  def create_relation(from_id,to_id,type,properties={})
    Restfulie.at("#{@host}/node/#{from_id}/relationships").accepts('application/json').as('application/json').post!(
    :to => "#{@host}/node/#{to_id}",:type => type,:data => properties)
  end
  
  def get_node(id)
    Restfulie.at("#{@host}/node/#{id}").accepts('application/json').get!
  end
  
end
