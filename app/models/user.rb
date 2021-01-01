# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :posts
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
