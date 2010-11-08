require 'spec_helper'


describe Neo4j::Node do

  before(:all) do    
    @server = Neo4j::Server.new('http://localhost:9999')
  end
 
  #retirado do restfulie
  def wait_server(port=9999)
    (1..15).each do
      begin
        retorno = Net::HTTP.get(URI.parse("http://localhost:#{port}/"))
        return
      rescue
        sleep 1
      end
    end
    raise "O servidor não subiu :("
  end  
  
  before do
    system "sh #{RAILS_ROOT}/spec/lib/neo4j/integration/neo4j-server-08/bin/neo4j-rest start"
    wait_server
  end
  
  after do
    system "sh #{RAILS_ROOT}/spec/lib/neo4j/integration/neo4j-server-08/bin/neo4j-rest stop"    
    FileUtils.rm_rf "#{RAILS_ROOT}/spec/lib/neo4j/integration/neo4j-server-08/neo4j-rest-db" 
  end
   

  it "deveria criar um nó com propriedades" do
    node = @server.create_node(:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')
    node.descricao.should eql 'O ruby conf foi muito bom'
    node.tipo.should eql 'comentario'
    node.id.should eql 1
  end

  
  it "deveria recuperar um no baseado em alguma propriedade" do      
    node = @server.create_node(:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')    
    node.index_with('tipo','comentario')
    comentarios = @server.find_nodes_by_property('tipo','comentario')
    comentarios.length.should eql 1
    comentarios[0].descricao.should eql 'O ruby conf foi muito bom'
    comentarios[0].tipo.should eql 'comentario'
  end    
            
  it "deveria recuperar um nó por id" do
    node = @server.create_node(:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')        
    no_recuperado = @server.find_node_by_id(node.id)
    no_recuperado.descricao.should eql 'O ruby conf foi muito bom'
    no_recuperado.tipo.should eql 'comentario'
  end
  
  it "deveria lancar exception caso o no a ser recuperado nao exista" do
        lambda {@server.find_node_by_id(100)}.should raise_error(Exception)
  end    
  
end
