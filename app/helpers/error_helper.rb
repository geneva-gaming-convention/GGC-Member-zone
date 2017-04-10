module ErrorHelper
  def render_404
    render :file => "#{Rails.root}/public/404",  :status => 404
  end

  def render_403
    render :file => "#{Rails.root}/public/403",  :status => 403
  end
end
