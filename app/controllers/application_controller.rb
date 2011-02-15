class ApplicationController < ActionController::Base
  # include all helpers, all the time
  helper :all 
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout 'application'

  @categories = Category.all
  @articles	  = Article.all
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
