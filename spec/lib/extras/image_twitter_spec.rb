require 'spec_helper'

include ImageTwitterHelper

describe ImageTwitterHelper do
  it "deveria extrair nome com extensao de 3 caracteres" do

    # mangue
    user = "a"
    Twitter.stub!(:user).and_return(user)
    user.should_receive(:profile_image_url).and_return("http://a1.twimg.com/profile_images/1100197947/Photo_3_reasonably_small.jpg")
    
    
    image, url = arquivo_para 'anderson_leite'
    image.should be == "anderson_leite.jpg"
  end
  
  it "deveria extrair nome com extensao de 4 caracteres" do
    user = "a"
    Twitter.stub!(:user).and_return(user)
    user.should_receive(:profile_image_url).and_return("http://a1.twimg.com/profile_images/1100197947/Photo_3_reasonably_small.jpeg")
    
    image, url = arquivo_para 'anderson_leite'
    image.should be == "anderson_leite.jpeg"
    
  end
  
end
