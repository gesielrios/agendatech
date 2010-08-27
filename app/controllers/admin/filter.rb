module Admin::Filter
  protected

  def admin_only
    before_filter :authenticate_admin!
    layout "admin"
  end
end
