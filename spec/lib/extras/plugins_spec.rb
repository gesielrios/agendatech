require 'spec_helper'

describe Plugins do
  it "deveria retornar ImageTwitter para dev e test" do
      obj = Plugins.new_image_twitter
      obj.class.should eq ImageTwitter
  end
  
  it "deveria retornar o ImageTwitter para s3 em prod" do
    Rails.env  = 'production'
    obj = Plugins.new_image_twitter
    obj.class.should eq ImageTwitterInS3
    Rails.env  = 'test'    
  end
end
