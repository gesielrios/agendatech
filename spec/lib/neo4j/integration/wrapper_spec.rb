require 'spec_helper'

describe Neo4j::Wrapper do

  before(:all) do    
     @host = 'http://localhost:9999'
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
    node = Neo4j::Node.create(@host,:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')
    node.descricao.should eql 'O ruby conf foi muito bom'
    node.tipo.should eql 'comentario'
    node.id.should eql 1
  end
  
  it "deveria adicionar no indice para ser buscado" do
    node = Neo4j::Node.create(@host,:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')    
    node.index_with('tipo','comentario')
  end
  
  it "deveria lancar exception caso o nó a ser adicionado no indice não exista" do
    fake_node = Neo4j::Node.new(@host,100)
    lambda {fake_node.index_with 'nome','alberto'}.should raise_error(Exception)
  end  
  
  it "deveria recuperar um no baseado em alguma propriedade" do      
    node = Neo4j::Node.create(@host,:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')    
    node_index_with('tipo','usuario')
    usuarios = Node.find_by_properties(node,'tipo','usuario')
    usuarios.length.should eql 1
    usuarios[0].data.nome.should eql 'Alberto'
    usuarios[0].data.tipo.should eql 'usuario'
  end    
  
        
  
  it "deveria recuperar um nó por id" do
    node = Neo4j::Node.create(@host,:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')        
    no_recuperado = Node.find_by_id(node.id)
    no_recuperado.descricao.should eql 'O ruby conf foi muito bom'
    no_recuperado.tipo.should eql 'comentario'
  end  
  
  it "deveria criar um relacionamento" do
    no_origem = Neo4j::Node.create(@host,:nome => 'Alberto', :tipo => 'usuario')        
    no_destino = Neo4j::Node.create(@host,:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')        
    relation = no_origem.create_relation_with(no_destino, 'comentario')
    relation.type.should eql 'comentario'
    relation.start.should eql no_origem.uri
    relation.end.should eql no_destino.uri
  end

  it "deveria criar um relacionamento com propriedades" do      
    no_origem = Neo4j::Node.create(@host,:nome => 'Alberto', :tipo => 'usuario')        
    no_destino = Neo4j::Node.create(@host,:descricao => 'O ruby conf foi muito bom', :tipo => 'comentario')        
    relation = no_origem.create_relation_with(no_destino, 'comentario',{:evento => 1})
    relation.type.should eql 'comentario'
    relation.evento.should eql 1
    relation.start.should eql no_origem.uri
    relation.end.should eql no_destino.uri            
  end
end
