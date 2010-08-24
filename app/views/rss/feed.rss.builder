xml.rss :version=>"2.0" do 
	xml.channel do 
		xml.title "agendatech | Eventos de Tecnologia no Brasil"
		xml.link "http://www.agendatech.com.br"
		xml.description "RSS dos eventos de tecnologia no Brasil | agendatech"
		xml.language 'pt-br'
		@eventos.each do |evento| 
			xml.item do 
				xml.title evento.nome
				xml.description evento.descricao
				xml.pubDate evento.data
				xml.link evento.site
			end 
		end 
	end 
end