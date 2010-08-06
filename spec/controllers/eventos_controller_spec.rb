require 'spec_helper'

describe EventosController do

  before do
    @evento = mock_model(Evento)
    Evento.stub!(:new).and_return(@evento)
    @evento.stub!(:aprovado=).and_return(false)
    @evento.stub!(:data=).and_return(Date.today)
    @evento.stub!(:save).and_return(true)
  end  
  
  it "deveria cadastrar um evento e deixar com aprovacao pendente e data de inicio = fim caso o fim não tenha sido definido" do
    @evento.stub!(:data).and_return(Date.today)
    @evento.stub!(:data_termino?).and_return(nil)
    @evento.stub!(:data_termino=).and_return(Date.today)    
    Evento.should_receive(:new).once
    @evento.should_receive(:aprovado=).once
    @evento.should_receive(:data=).once
    @evento.should_receive(:save).once
    get "create"
    @evento.should_receive(:data_termino=).once
    response.should redirect_to :action => 'index'
  end


  it "deveria testar eventos por mes" do
    pending
  end
  
  it "deveria testar eventos por estado" do
    pending
  end  
  
end
