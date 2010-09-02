require 'spec_helper'

describe CalendarioController do

  #Delete this example and add some real ones
  it "deveria adicionar os todos os eventos ao calendario" do
    qcon = mock_model(Evento)
    qcon.should_receive(:data).exactly(3).times.and_return(Time.now)
    qcon.should_receive(:data_termino).exactly(3).times.and_return(Time.now)
    qcon.should_receive(:nome).and_return('Qcon')
    qcon.should_receive(:descricao).and_return('descrevendo')
    eventos = []
    eventos << qcon
    Evento.should_receive(:all).and_return(eventos)
    get 'index'
  end
  
  it "deveria adicionar os todos os eventos do estado ao calendario" do
    qcon = mock_model(Evento)
    qcon.should_receive(:data).exactly(3).times.and_return(Time.now)
    qcon.should_receive(:data_termino).exactly(3).times.and_return(Time.now)
    qcon.should_receive(:nome).and_return('Qcon')
    qcon.should_receive(:descricao).and_return('descrevendo')
    eventos = []
    eventos << qcon
    Evento.should_receive(:estado_aprovado).with('BA').and_return(eventos)
    get 'index',:estado => 'Bahia'
  end  

end
