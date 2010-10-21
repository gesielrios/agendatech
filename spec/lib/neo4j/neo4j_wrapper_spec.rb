require 'spec_helper'

describe Neo4j::Neo4jWrapper do

  before do
     @server = Neo4j::Neo4jWrapper.new('http://localhost:9999')     
  end
  
  
  before(:each) do
    system "sh #{RAILS_ROOT}/spec/lib/neo4j/neo4j-server-08/bin/neo4j-rest start"
  end
  
  after(:each) do
    system "sh #{RAILS_ROOT}/spec/lib/neo4j/neo4j-server-08/bin/neo4j-rest stop"    
    FileUtils.rmdir "#{RAILS_ROOT}/spec/lib/neo4j/neo4j-server-08/bin/neo4j-rest-db" 
  end
   

  it "deveria criar um nó com propriedades" do
    no = @server.create_node :descricao => 'O ruby conf foi muito bom', :tipo => 'comentario'
    @server.get_node  1
    no.descricao.should be 'O ruby conf foi muito bom'
    no.tipo.should be 'comentario'
  end
  
  it "deveria criar um relacionamento" do
    no_origem = @server.create_node :nome => 'Alberto', :tipo => 'usuario'
    no_destino = @server.create_node :descricao => 'O ruby conf foi muito bom', :tipo => 'comentario'
    relation = @server.create_relation :type => 'comentario', :origin => no_origem, :destiny => no_destino
    @server.relations.length.should be 1
    relation.origin.should be no_origem
    relation.destiny.should be no_destino
  end

  it "deveria criar um relacionamento com propriedades" do      
    no_origem = @server.create_node :nome => 'Alberto', :tipo => 'usuario'
    no_destino = @server.create_node :descricao => 'O ruby conf foi muito bom', :tipo => 'comentario'
    relation = @server.create_relation :type => 'comentario', :origin => no_origem,
                                        :destiny => no_destino, :properties => {:evento => 1} 
    @server.relations.length should be 1
    relation.origin.should be no_origem
    relation.destiny.should be no_destino
    relation.properties.length.should be 1            
  end
  
end
