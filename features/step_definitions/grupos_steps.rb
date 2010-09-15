Dado /^que o grupo "([^\"]*)" possui o evento "([^\"]*)"$/ do |grupo, evento|
  Grupo.find_by_nome(grupo).eventos.create!({
    :nome      => evento,
    :aprovado  => true,
    :site      => 'http://www.example.com',
    :data      => Date.today,
    :descricao => 'Alo 123',
    :estado    => 'SP'
  })
end
