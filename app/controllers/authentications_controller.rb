require 'image_twitter'

class AuthenticationsController < ApplicationController
  def index  
    @authentications = current_user.authentications if current_user 
  end  

  def create  
    omniauth = request.env["omniauth.auth"]  
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])  
 
    # user is already registered
    if authentication  
      flash[:notice] = "Signed in successfully."  
      sign_in_and_redirect(:user, authentication.user)  
    elsif current_user  
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])  
      flash[:notice] = "Authentication successful."  
      redirect_to authentications_url  
    # new user  
    else  
      # TODO : email must be unique in devise...
      user = User.new :email => omniauth['user_info']['nickname'], :nickname => omniauth['user_info']['nickname'], :image => omniauth['user_info']['image'] 
      user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      user.save!  

      # download user image
      Plugins.new_image_twitter.download omniauth['user_info']['nickname']
      
      flash[:notice] = "Signed in successfully."  
      sign_in_and_redirect(:user, user)  
    end 
  end  

  def destroy  
    @authentication = current_user.authentications.find(params[:id])  
    @authentication.destroy  
    flash[:notice] = "Successfully destroyed authentication."  
    redirect_to authentications_url 
  end
end
