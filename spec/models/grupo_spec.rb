require 'spec_helper'

describe Grupo do
  it { should have_many :eventos }
  it { should validate_presence_of :nome }
  it { should validate_presence_of :site }  
  it { should have_scope :nao_aprovados, :conditions => { :aprovado => false } }
  it { should have_scope :aprovados, :conditions => { :aprovado => true } }

  it { should have_scope :por_nome, :order => 'nome ASC'  }

  describe "uniqueness of name" do
    before(:each) { Grupo.create(:nome => 'GURU-SP') }
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
