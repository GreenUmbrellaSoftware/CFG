class UserAccessRequestsController < ApplicationController
  layout false

  skip_before_action :set_user
  def index
    user = User.current_user
    if user.pending
      @content = 'Thank you for your interest in CFG. Your account is pending approval.'
    else
      @content = 'Thank you for your interest in CFG. Your account has not been approved. <br/>Contact the system admininstrator if you believe this is an error.'
    end

  end

end