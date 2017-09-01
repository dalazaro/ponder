class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  #methods for API documentation, splash page
  def splash
    render('../views/splash')
  end
  #format: json render: partial => "users/show"
end
