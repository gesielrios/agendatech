module Neo4j
  
  class Node
    @@mime_type =  'application/json'     
    @properties
    attr_reader :id
    
    def initialize(host,id)
      @id = id
      @host = host
    end
    
    def self.create(host,properties={})
      neo_node = Restfulie.at("#{host}/node").accepts(@@mime_type).as(@@mime_type).post!(properties)
      node = Node.new(host,neo_node.self.split('/node/')[1].to_i)
      node.send('properties=',neo_node)
      node
    end
    
    def index_with(key,value)
        uri = URI.parse(@host)      
        response = Net::HTTP.start(uri.host,uri.port){ |req|
                      req.post("/index/node/#{key}/#{value}","#{@host}/node/#{@id}",{'Content-Type' => 'text/plain'})
                   }                 
        if response.code.to_i != 201                                        
          raise "Não foi possivel adicionar o nó no indice com as propriedades. Código de retorno => #{response.code}" 
        end
    end
        
    
    def method_missing(nome,*args)      
      if @properties.data.has_key?(nome.to_s)        
        return @properties.data[nome.to_s]
      else
        raise "Não existe a propriedade de nome #{nome}"     
      end
    end
    
    private 
    def properties=(neo_node)
      @properties = neo_node
    end
  end
  class Wrapper
    @@mime_type =  'application/json' 
    
    def initialize(host)
      @host = host
    end
    
    
    def create_node(properties={})
      Restfulie.at("#{@host}/node").accepts(@@mime_type).as(@@mime_type).post!(properties)
    end
    
    def get_node(id)
      Restfulie.at("#{@host}/node/#{id}").accepts(@@mime_type).get!
    end    
    
    def create_relation(from_id,to_id,type,properties={})
      Restfulie.at("#{@host}/node/#{from_id}/relationships").accepts(@@mime_type).as(@@mime_type).post!(
      :to => "#{@host}/node/#{to_id}",:type => type,:data => properties)
    end
    
    def index(node_id,key,value)
        uri = URI.parse(@host)      
        response = Net::HTTP.start(uri.host,uri.port){ |req|
                      req.post("/index/node/#{key}/#{value}","#{@host}/node/#{node_id}",{'Content-Type' => 'text/plain'})
                   }                 
        raise "Não foi possivel adicionar o nó no indice com as propriedades. Código de retorno => #{response.code}" unless response.code != 201               
    end  
    
    def find_by_properties(key,value)
      Restfulie.at("#{@host}/index/node/#{key}/#{value}").accepts(@@mime_type).get!
    end
    
    
  end
end
