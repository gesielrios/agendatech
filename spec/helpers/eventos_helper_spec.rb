require 'spec_helper'

describe EventosHelper do



  it "should generate a valid url based on the event" do
    evento = Evento.create(:data => Date.today)
    helper.evento_full_path(evento).should == evento_path(:ano => Date.today.year, :id => evento)
  end


end
