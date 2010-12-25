require "spec_helper"

describe Notifier do
  it "deveria enviar um email" do
    contato = Contato.new :nome => "Alberto",:mensagem => "oi",:mensagem => "msg"
    email = Notifier.envia_email(contato).deliver
    ActionMailer::Base.deliveries.empty?.should be_false
  end
end
