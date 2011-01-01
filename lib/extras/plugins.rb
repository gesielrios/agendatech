class Plugins
  def self.paper_clip(model)
    EnvironmentHack.para do |env|
      env.producao {
        model.has_attached_file :logo,           
          :storage => :s3, 
          :path => "/:style/:filename",
          :styles => { :medium => "195x189>", :thumb => "97x97>" }  ,
          :bucket => ENV['S3_BUCKET'],
          :s3_credentials => { :access_key_id => ENV['S3_KEY'],                                
          :secret_access_key => ENV['S3_SECRET'] }          
      }
      env.outros {
        model.has_attached_file :logo, :styles => { :medium => "195x189>", :thumb => "97x97>" }                
      }
     end
  end
   
   def self.new_image_twitter
     EnvironmentHack.para do |env|
       env.producao {
          return ImageTwitterInS3.new
       }
       env.outros {
          return ImageTwitter.new         
       }
     end     
   end  
end
