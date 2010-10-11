class Heroku
  def self.paper_clip
    {
          :storage => :s3, 
          :path => "/:style/:filename",
          :styles => { :medium => "195x189>", :thumb => "97x97>" }  ,
          :bucket => ENV['S3_BUCKET'],
          :s3_credentials => { :access_key_id => ENV['S3_KEY'],                                
          :secret_access_key => ENV['S3_SECRET'] }          
    }
  end
end
