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
  
  
 it "deveria adicionar no indice para ser buscado" do
    node = @server.create_node(:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')    
    node.index_with('tipo','comentario')
  end
  
  it "deveria lancar exception caso seja instanciado um no que nao existe no servidor" do
    fake_node = Neo4j::Node.new(@host,100)
    lambda {fake_node.index_with 'nome','alberto'}.should raise_error(Exception)
  end    
  it "deveria criar um relacionamento" do
    no_origem = @server.create_node(:nome => 'Alberto', :tipo => 'usuario')        
    no_destino = @server.create_node(:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')        
    relation = no_origem.create_relation_with(no_destino, 'comentario')
    relation.nature.should eql 'comentario'
    relation.start.should eql no_origem.uri
    relation.end.should eql no_destino.uri
  end


  it "deveria criar um relacionamento com propriedades" do      
    no_origem = @server.create_node(:nome => 'Alberto', :tipo => 'usuario')        
    no_destino = @server.create_node(:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')        
    relation = no_origem.create_relation_with(no_destino, 'comentario',{:evento => 1})
    relation.nature.should eql 'comentario'
    relation.evento.should eql 1
    relation.start.should eql no_origem.uri
    relation.end.should eql no_destino.uri
  end  
end
