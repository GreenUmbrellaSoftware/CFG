class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_user

  def set_user
    return @user if @user.present?
    headers = request.headers
    dn = headers['HTTP_SSL_CLIENT_S_DN']

    if dn.present?
      cn = headers['HTTP_SSL_CLIENT_S_DN_CN']
      User.current_user = User.where(:dn => dn).first_or_create(:cn => cn)
    end

    @user = User.current_user

    if User.where(:active => true, :pending => false).count <= 0
      @user.active = true
      @user.pending = false
      @user.save
    end

    if @user.pending
      redirect_to user_access_requests_url
      return
    end

    unless @user.active
      redirect_to user_access_requests_url
    end

    @user
  end
end
