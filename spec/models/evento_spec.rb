require 'spec_helper'

describe Evento do
  
    before(:all) do
       @evento1 = Evento.create :nome => "evento", :descricao => "desc", :site => "http://www.example.com", :data => '01/01/2011', :estado => 'BA',:aprovado => true
       @evento2 = Evento.create :nome => "evento1", :descricao => "desc", :site => "http://www.example.com", :data => '01/01/2011', :estado => 'BA',:aprovado => true
       @evento3 = Evento.create :nome => "evento2", :descricao => "desc", :site => "http://www.example.com", :data => '01/02/2011', :estado => 'SP',:aprovado => true                           
       Gadget.create :tipo => Gadget.tipos[:eu_vou], :evento_id => @evento1.id, :user_id => 1
    end              
    
    before(:each) do
       @data_base = "10/10/2010"
       @evento = Evento.new :nome => "evento", :descricao => "desc", :site => "http://www.example.com", :data => @data_base
    end
  
  describe "validando as datas" do    


    it "deveria validar a data de inicio apenas para eventos não aprovados" do    
      #por algum motivo, o qual desconheco :), nao ta rolando garantir so ano com 4 digitos. Mesmo assim o plugin
      #ainda ta pegando certo.     
      @evento.data = "10/13/10"
      @evento.should_not be_valid
      @evento.aprovado = true
      @evento.should be_valid
    end

    it "deveria validar a data de termino apenas para eventos não aprovados" do
        @evento.data_termino = "10/13/10"
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
  end  
  
  describe "verificando as listagens dos eventos aprovados" do      
    
      it "deveria listar todos eventos que ainda vao ocorrer" do
          Evento.nao_ocorrido.length.should eq(3)
      end           
      
      it "deveria listar todos os eventos do mes" do
          Evento.por_mes(1).length.should eq(2)
      end
      
      it "deveria listar todos os eventos aprovados por estado" do
          Evento.estado_aprovado('BA').length.should eq(2)
      end
      
      it "deveria listar todos os eventos com os gadgets de algum tipo" do
          Evento.nao_ocorrido.top_gadgets.length.should eq(3)
      end
    
  end
       
end
