require 'spec_helper'

describe EventosHelper do

  it "deveria gerar uma url valida baseada no evento" do
    evento = Evento.create(:nome => 'nome',:descricao => 'desc',:site => 'http://www.teste.com.br',:data => Date.today)
    helper.evento_full_path(evento).should == evento_path(:ano => Date.today.year, :id => evento)
 end
 
  it "deveria retornar os estados com numero de eventos e a somatoria de eventos" do
    Evento.should_receive(:agrupado_por_estado).and_return({"BA" => 2,"SP" => 1})
    estados,total = helper.estados_com_total_de_eventos
      estados.size.should eq 2
      total.should eq 3
  end
  
  it "deveria retornar os meses com numero de eventos e a somatoria de eventos do ano corrente" do
    Evento.should_receive(:agrupado_por_mes).and_return({12 => 2,10 => 4})
    meses,total = helper.meses_com_total_de_eventos
      meses.size.should eq 2
      total.should eq 6
  end  


end
