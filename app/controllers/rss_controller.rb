class RssController < ApplicationController

  	def feed
			@eventos = Evento.all

			respond_to do |format|
				format.rss {render :layout => false}
				format.atom {render :layout => false}
				format.json {render :json => @carros.to_json}
				format.html {index}
			end
		end

end
