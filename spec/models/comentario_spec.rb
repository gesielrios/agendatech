require 'spec_helper'

describe Comentario do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Comentario.create!(@valid_attributes)
  end
end
