Dado /^que o evento abaixo existe:$/ do |table|
  table.hashes.each do |hash|
    e = Evento.new hash
    e.data = Time.now
    e.save
  end
end

Dado /^que o evento abaixo existe com o termino para hoje:$/ do |table|
  table.hashes.each do |hash|
    e = Evento.new hash
    e.data = Date.today - 1
    e.data_termino = Date.today
    e.save
  end
end

Dado /^que o evento abaixo existe com a data de inicio no futuro:$/ do |table|
  table.hashes.each do |hash|
    e = Evento.new hash
    e.data = Date.today + 10
    e.data_termino = Date.today + 15
    e.save
  end
end

Dado /^que estou como administrador$/ do
  Admin.create :email => 'admin@admin.com', :password => 'adminspassword'
  visit "/admin"

  fill_in "Email", :with => 'admin@admin.com'
  fill_in "Password", :with => 'adminspassword'

  click_button "Sign in"
end

Dado /^(?:|que )estou na pagina administrativa$/ do
  visit "/admin"
end

Quando /^clico no link para "([^\"]*)"$/ do |link|
  click_link link
end

Entao /^deveria ver o "([^\"]*)" na lista de eventos$/ do |texto|
  page.should have_content texto
end

Entao /^deveria ver a página de login$/ do
  page.should have_content "Login"
end
