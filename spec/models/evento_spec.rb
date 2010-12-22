require 'spec_helper'

describe Evento do

  before(:each) do
     @data_base = "10/10/2010"
     @evento = Evento.new :nome => "evento", :descricao => "desc", :site => "http://www.example.com", :data => @data_base
   end

  it "deveria validar a data de inicio apenas para eventos não aprovados" do
    @evento.data = "10/10/10"
    @evento.should_not be_valid
    @evento.aprovado = true
    @evento.should be_valid
  end

  it "deveria validar a data de termino apenas para eventos não aprovados" do      
      @evento.data_termino = "10/10/10"
      @evento.should_not be_valid
      @evento.aprovado = true
      @evento.should be_valid
  end


  it "deveria falar que o evento esta rolando se a data de termino eh vazia e o dia eh hoje" do
    @evento.data = Date.today
    @evento.data_termino = nil
    @evento.should be_ta_rolando
  end

  it "deveria verificar que a data de termino é posterior a data de inicio" do
    @evento.data_termino = @evento.data - 1.day
    @evento.should_not be_valid
    @evento.data_termino = @evento.data + 1.day
    @evento.should be_valid
  end

  it "deveria verificar se o dia está no intervalo do de dias do evento" do
    @evento.data = Date.today
    @evento.data_termino = Date.today + 2.day
    @evento.should be_ta_rolando
    @evento.data = Date.today + 4.day
    @evento.data_termino = Date.today + 6.day
    @evento.should_not be_ta_rolando
  end
  
  it "deveria configurar o paperclip para usar o amazon-s3 em modo de producao" do
    pending
  end  
  
  it "deveria listar todos eventos que ainda vao ocorrer" do
           Evento.create(:data => @evento.data + 10.day,:nome => 'teste',
                         :site => 'http://www.teste.com.br',
                         :descricao => 'testando' )
            Evento.create(:data => @evento.data + 10.day,:nome => 'teste',
                          :site => 'http://www.teste.com.br',
                          :descricao => 'testando' )
  end           
  
  it "deveria listar todos os eventos do mes" do
    pending
  end
  
  it "deveria listar todos os eventos aprovados por estado" do
    pending
  end
  
  it "deveria listar todos os eventos com os gadgets de algum tipo" do
    pending
  end
    
       
end
