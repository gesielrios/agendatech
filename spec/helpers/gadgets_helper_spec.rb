require 'spec_helper'

describe GadgetsHelper do

  it "deveria devolver extencao com 3 caracteres" do
    gadget = Gadget.new :user_id => 1
    user = User.new :image => "anderson_leite.jpg"
    User.should_receive(:find).with(1).and_return(user)
    
    helper.extension(gadget).should be == "jpg"
  end

  it "deveria devolver extencao com 4 caracteres" do
    gadget = Gadget.new :user_id => 1
    user = User.new :image => "anderson_leite.jpeg"
    User.should_receive(:find).with(1).and_return(user)
    
    helper.extension(gadget).should be == "jpeg"
  end
    

end


