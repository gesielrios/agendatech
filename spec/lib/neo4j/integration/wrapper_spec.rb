require 'spec_helper'

describe Neo4j::Wrapper do

  before(:all) do
     @server = Neo4j::Wrapper.new('http://localhost:9999')     
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
    no = @server.create_node :descricao => 'O ruby conf foi muito bom', :tipo => 'comentario'
    no.data.descricao.should eql 'O ruby conf foi muito bom'
    no.data.tipo.should eql 'comentario'
  end
  
  it "deveria adicionar no indice para ser buscado" do
    no = @server.create_node :descricao => 'O ruby conf foi muito bom', :tipo => 'comentario'
    @server.index 1,'tipo','comentario'    
  end
  
  it "deveria buscar por um nó pelo indice" do
    pending    
  end      
  
  it "deveria recuperar um nó por id" do
    no = @server.create_node :descricao => 'O ruby conf foi muito bom', :tipo => 'comentario'
    no_recuperado = @server.get_node 1
    no.data.descricao.should eql 'O ruby conf foi muito bom'
    no.data.tipo.should eql 'comentario'
  end  
  
  it "deveria criar um relacionamento" do
    no_origem = @server.create_node :nome => 'Alberto', :tipo => 'usuario'
    no_destino = @server.create_node :descricao => 'O ruby conf foi muito bom', :tipo => 'comentario'
    relation = @server.create_relation 1 , 2, 'comentario'
    relation.type.should eql 'comentario'
    relation.start.should eql no_origem.self
    relation.end.should eql no_destino.self
  end

  it "deveria criar um relacionamento com propriedades" do      
    no_origem = @server.create_node :nome => 'Alberto', :tipo => 'usuario'
    no_destino = @server.create_node :descricao => 'O ruby conf foi muito bom', :tipo => 'comentario'
    relation = @server.create_relation 1, 2, 'comentario', :evento => 1
    relation.type.should eql 'comentario'
    relation.data.evento.should eql 1
    relation.start.should eql no_origem.self
    relation.end.should eql no_destino.self            
  end
  
  it "deveria recuperar um no baseado em alguma propriedade" do      
    no_origem = @server.create_node :nome => 'Alberto', :tipo => 'usuario'
    no_destino = @server.create_node :descricao => 'O ruby conf foi muito bom', :tipo => 'comentario'
    no_encontrado = @server.find_by_properties :key => 'tipo', :value => 'comentario'
    no_encontrado.data.tipo.should eql 'comentario'
  end  
  
  
    
end
