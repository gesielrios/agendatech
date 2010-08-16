Dado /^que o administrador abaixo esta cadastrado:$/ do |table|
  table.hashes.each do |hash|
    Admin.create hash
  end
end
