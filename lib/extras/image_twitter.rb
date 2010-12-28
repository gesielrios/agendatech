require 'twitter'
require 'open-uri'
require 'find'

class ImageTwitter
  def self.download user_name

    image_url =  Twitter.user(user_name).profile_image_url
    image_name = image_url.match(/([\w_]+).(\w\w\w)$/)
    file_path =  "#{Rails.root}/public/images/twimages/#{user_name}.#{image_name[2]}"

    unless File.exists?(file_path)
      File.open(file_path, 'w') do |output|
        open(image_url) do |input|
          output << input.read
        end
      end
    end

  end
end
