class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  # method for splash page
  def splash
    render('../views/splash')
  end

  # method for API doc, format: json render: partial => "users/show"
end
