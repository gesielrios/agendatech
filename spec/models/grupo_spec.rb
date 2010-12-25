require 'spec_helper'

describe Grupo do

  describe "uniqueness of name" do
    before(:each) { Grupo.create(:nome => 'GURU-SP', :site => 'http://guru-sp.com/') }
    it { should validate_uniqueness_of :nome }
  end

  describe "#aprovar!" do
    it "deve aprovar o grupo" do
      grupo = described_class.create(:nome => 'GURU-SP', :aprovado => true)
      grupo.aprovar!
      grupo.should be_aprovado
    end
  end

  describe "#reprovar!" do
    it "deve reprovar o grupo" do
      grupo = described_class.create(:nome => 'GURU-SP', :aprovado => true)
      grupo.reprovar!
      grupo.should_not be_aprovado
    end
  end
end
