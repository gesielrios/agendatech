Dado /^que o evento abaixo existe:$/ do |table|
  table.hashes.each do |hash|
    e = Evento.new hash
    e.data = Time.now
    e.save
  end  
end

Dado /^que estou na pagina administrativa$/ do
  visit "/admin"
end

Quando /^clico no link para "([^\"]*)"$/ do |link|
  click_link link
end

Entao /^deveria ver o "([^\"]*)" na lista de eventos$/ do |texto|
  page.should have_content texto
end
