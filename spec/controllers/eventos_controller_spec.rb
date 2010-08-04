require 'spec_helper'

describe EventosController do

  before do
    @evento = mock_model(Evento)
    Evento.stub!(:new).and_return(@evento)
    @evento.stub!(:aprovado=).and_return(false)
    @evento.stub!(:save).and_return(true)
  end  
  
  it "deveria cadastrar um evento e deixar com aprovacao pendente" do
    Evento.should_receive(:new).once
    @evento.should_receive(:aprovado=).once
    @evento.should_receive(:save).once
    get "create"
    response.should redirect_to :action => 'index'
  end

  it "deveria testar eventos por mes" do
    pending
  end
  
  it "deveria testar eventos por estado" do
    pending
  end  
  
end
