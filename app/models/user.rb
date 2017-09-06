class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_attached_file :image, styles:{ large: "600x600>", medium: "400x400>", thumb: "100x100"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.confirm(params)
    @user = User.find_by email: params[:email]
    @user ? @user.authenticate(params[:password]) : false
  end
end
