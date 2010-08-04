Dado /^que estou na pagina inicial$/ do
  visit "/"
end

Quando /^clico no link "([^\"]*)"$/ do |link|
  click_link link
end

E /^preencho o campo nome com "([^"]*)"$/ do |nome|
  fill_in "evento[nome]",:with=>nome
end

E /^preencho o campo site com "([^"]*)"$/ do |site|
  fill_in "evento[site]",:with=>site  
end

E /^preencho o campo data com "([^"]*)"$/ do |data|
  fill_in "evento[data]",:with=>data
end

E /^preencho o campo descricao com "([^"]*)"$/ do |descricao|
  fill_in "evento[descricao]",:with=>descricao
end

Quando /^clico no botao "([^\"]*)"$/ do |botao|
  click_button botao
end


Entao /^deveria ver o "([^\"]*)" na lista$/ do |texto|
  page.should have_content texto
end

Quando /^clico no mes do evento$/ do
  click_link Date::MONTHNAMES[Time.now.month]
end

Quando /^clico no estado do evento$/ do
  click_link "São Paulo           "
end
