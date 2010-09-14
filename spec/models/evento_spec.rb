require 'spec_helper'

describe Evento do

  it { should belong_to :grupo }

  it { should have_scope :nao_ocorrido,
    :conditions=> ["aprovado = ? AND ((? between data and data_termino) OR (data >= ?))  ", true, Date.today,Date.today],
    :order => 'data ASC'
  }

  it "deveria validar a data de inicio apenas para eventos não aprovados" do
    pending
  end

  it "deveria validar a data de termino apenas para eventos não aprovados" do
    pending
  end

  it "deveria validar a data de termino apenas caso ela tenha sido preenchida" do
    pending
  end

  it "deveria verificar que a data de termino é posterior a data de inicio" do
    pending
  end

  it "deveria verificar se o dia está no intervalo do de dias do evento" do
    pending
  end
end
