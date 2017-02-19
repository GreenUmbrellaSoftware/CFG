class HomeController < ApplicationController
  def index
    @pending = User.where(:pending => true)
  end
end
