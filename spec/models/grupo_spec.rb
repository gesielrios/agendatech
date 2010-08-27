require 'spec_helper'

describe Grupo do
  it { should have_many :eventos }
  it { should validate_presence_of :nome }
  it { should have_scope :nao_aprovados, :conditions => { :aprovado => false } }

  describe "uniqueness of name" do
    before(:each) { Grupo.create(:nome => 'GURU-SP') }
    it { should validate_uniqueness_of :nome }
  end

  describe "#aprovar!" do
    let(:grupo) { described_class.create(:nome => 'GURU-SP', :aprovado => false) }
    subject { grupo }

    before(:each) { grupo.aprovar! }
    its(:aprovado) { should be_true }
  end

  describe "#reprovar!" do
    let(:grupo) { described_class.create(:nome => 'GURU-SP', :aprovado => true) }
    subject { grupo }

    before(:each) { grupo.reprovar! }
    its(:aprovado) { should be_false }
  end
end
