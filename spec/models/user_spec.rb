require 'spec_helper'

describe Grupo do

  describe "vai no evento" do
    before(:all) do
      @user = User.create :nickname => "teste",:email => "teste@teste.com.br",:image => "http://a3.twimg.com/profile_images/1201901056/ic_launcher.png"
      @evento = Evento.create :nome => "evento", :descricao => "desc", :site => "http://www.example.com", :data => "10/09/2020", :estado => 'BA',:aprovado => true      
    end
    
    it "deveria retornar false caso nao fosse" do
      @user.vai_no?(@evento).should be_false      
    end
    
    it "deveria retornar true caso fosse" do
      Gadget.create :tipo => Gadget.tipos[:eu_vou], :evento_id => @evento.id, :user_id => @user.id      
      @user.vai_no?(@evento).should be_true      
    end    
  end
end
