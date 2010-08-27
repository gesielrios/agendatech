class Admin::AdminController < ApplicationController
  before_filter :authenticate_admin!

  def index
    redirect_to admin_eventos_path
  end
end
