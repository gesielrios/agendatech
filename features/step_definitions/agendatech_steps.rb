Dado /^que estou na pagina inicial$/ do
  visit "/"
end

Quando /^clico no link "([^\"]*)"$/ do |link|
  click_link link
end

E /^preencho o campo nome com "([^"]*)"$/ do |nome|
  fill_in "evento[nome]",:with=>nome
end

E /^preencho o campo estado com "([^"]*)"$/ do |estado|
  select  estado, :from => "evento[estado]"
end

E /^preencho o campo site com "([^"]*)"$/ do |site|
  fill_in "evento[site]",:with=>site
end

E /^preencho o campo data com "([^"]*)"$/ do |data|
  fill_in "evento[data]",:with=>data
end

E /^preencho o campo data_termino com "([^"]*)"$/ do |data_termino|
  fill_in "evento[data_termino]",:with=>data_termino
end

E /^preencho o campo descricao com "([^"]*)"$/ do |descricao|
  fill_in "evento[descricao]",:with=>descricao
end
Quando /^preencho o campo "([^"]*)" com "([^"]*)"$/ do |label, conteudo|
  fill_in label, :with => conteudo
end

Quando /^clico no botao "([^\"]*)"$/ do |botao|
  click_button botao
end


Entao /^deveria ver o "([^\"]*)" na lista$/ do |texto|
  page.should have_content texto
end

Entao /^deveria ver "([^\"]*)" na pagina$/ do |texto|
  page.should have_content texto
end

Entao /^não deveria ver o "([^\"]*)" na lista$/ do |texto|
  page.should_not have_content texto
end

Quando /^clico no mes do evento$/ do
  click_link I18n.l(Time.now, :format => :month)
end

Quando /^clico no estado do evento$/ do
  click_link "São Paulo           "
end
