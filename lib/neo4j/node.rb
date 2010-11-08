module Neo4j  
       
  class Node
    include GraphPart
    @@mime_type =  'application/json'
    @properties
    attr_reader :id
    
    def initialize(host,id)
      @server = Server.new(host)
      @id = id
    end  
    
    def index_with(key,value)
        uri = URI.parse(@server.host)      
        response = Net::HTTP.start(uri.host,uri.port){ |req|
                      req.post("/index/node/#{key}/#{value}","#{@server.host}/node/#{@id}",{'Content-Type' => 'text/plain'})
                   }                 
        if response.code.to_i != 201                                        
          raise "Não foi possivel adicionar o nó no indice com as propriedades. Código de retorno => #{response.code}" 
        end
    end 
    
    def create_relation_with(to,type,properties={})
      neo_relation = Restfulie.at("#{self.uri}/relationships").accepts(@@mime_type).as(@@mime_type).post!(
      :to => to.uri,:type => type,:data => properties)
      relation = Relation.new
      relation.send('properties=',neo_relation) 
      relation     
    end                     
        
  end
  
  class Relation    
    include GraphPart   
    
    def nature
      @properties["type"]
    end     
    
  end
  
  class Server    
    @@mime_type =  'application/json'
    attr_reader :host
    def initialize(host)
      @host = host
    end            
    
    def create_node(properties={})
      neo_node = Restfulie.at("#{@host}/node").accepts(@@mime_type).as(@@mime_type).post!(properties)
      extract_node_based_on(neo_node)      
    end
    
    def find_nodes_by_property(key,value)
      neo_nodes = Restfulie.at("#{@host}/index/node/#{key}/#{value}").accepts(@@mime_type).get!
      nodes = []
      neo_nodes.each do |neo_node|
        nodes << extract_node_based_on(neo_node)
      end
      nodes
    end   
    
    def find_node_by_id(id)
      neo_node = Restfulie.at("#{@host}/node/#{id}").accepts(@@mime_type).get!
      extract_node_based_on(neo_node)      
    end             
    
    private     
    def extract_node_based_on(neo_node)
      node = Node.new(@host,neo_node.self.split('/node/')[1].to_i)
      node.send('properties=',neo_node)            
      node      
    end        
  end
end
