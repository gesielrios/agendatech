require 'twitter'
require 'open-uri'
require 'find'
require 'aws/s3'

module ImageTwitterHelper
  def arquivo_para user_name
    image_url =  Twitter.user(user_name).profile_image_url
    image_name = image_url.match(/([\w_]+).(\w\w\w)$/)
    return "#{user_name}.#{image_name[2]}", lambda{ open(image_url)}
  end
end

class ImageTwitter
  include ImageTwitterHelper  
  def self.download user_name
      nome,faz_download = arquivo_para user_name
      file_path =  "#{Rails.root}/public/images/twimages/#{nome}"
      unless File.exists?(file_path)
          File.open(file_path, 'w') do |output|
            faz_download.call do |input|
                output <<  input.read            
            end
          end
      end
   end           
end

class ImageTwitterInS3 <  AWS::S3::S3Object
  include ImageTwitterHelper    
  set_current_bucket_to 'twitter_images'
  
  def self.download user_name
    nome,faz_download = arquivo_para user_name
    unless exists? nome
      store faz_download.call
    end
  end
end
