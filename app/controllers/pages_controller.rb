class PagesController < ApplicationController
  def home
  	@title = "Home"
  	unless user_signed_in?
  		redirect_to root_path
  	end
  end

  def welcome
  	@title = "Welcome"
  	if user_signed_in?
  		redirect_to home_path
  	end
  end
end
