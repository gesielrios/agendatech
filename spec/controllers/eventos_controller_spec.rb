require 'spec_helper'

describe EventosController do
  before(:all) do
     @evento1 = Evento.create :nome => "evento", :descricao => "desc", :site => "http://www.example.com", :data => "10/09/2020", :estado => 'BA',:aprovado => true
     @evento2 = Evento.create :nome => "evento1", :descricao => "desc", :site => "http://www.example.com", :data => "10/10/2020", :estado => 'BA',:aprovado => true
     @evento3 = Evento.create :nome => "evento2", :descricao => "desc", :site => "http://www.example.com", :data => "10/10/2020", :estado => 'SP',:aprovado => true                           
  end
  
  describe "get para a home" do
    
    it "listar todos que estao para acontecer" do
      get :index
      assigns[:eventos].length.should eq 3
    end
    
    it "listar todos que estao para acontecer em determinado mes" do
      get :index , {:month => "Outubro"}
      assigns[:eventos].length.should eq 2
    end
    
    it "listar todos que estao para acontecer em determinado estado" do
      get :index , {:estado => "São Paulo"}
      assigns[:eventos].length.should eq 1
    end                                                
  end
  
  describe "get para show" do
    it "deveria carregar o evento baseado no id" do
      get :show, {:id => @evento2.to_param}
      assigns[:evento].should eq @evento2
      assigns[:comentario].should_not be_nil
    end
  end
  
  describe "post para create" do
    it "deveria salvar o evento com a data de termino igual a de inicio caso nao tenha sido passada a de termino" do
      post :create, :evento => {:nome => "evento", :descricao => "desc", :site => "http://www.example.com", :data => Date.today, :estado => 'BA'}
      assigns[:evento].aprovado.should be_false
      assigns[:evento].data_termino.to_date.should eq Date.today.to_date
      flash[:aguarde].should eq "Obrigado! Seu evento aparecerá na lista em instantes!"
      response.should redirect_to :action =>"index"
    end
    
    it "deveria salvar o evento com a data de termino especificada" do
      data_termino = Date.today + 1.day
      post :create, :evento => {:nome => "evento", :descricao => "desc", :site => "http://www.example.com", :data => Date.today,:data_termino => data_termino ,:estado => 'BA'}
      assigns[:evento].aprovado.should be_false
      assigns[:evento].data_termino.to_date.should eq data_termino
      flash[:aguarde].should eq "Obrigado! Seu evento aparecerá na lista em instantes!"
      response.should redirect_to :action =>"index"
    end            
  end
  

end
