class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token, :name, :reset_token, :stripe_id

  has_many :cards, :dependent => :destroy
  has_many :subscriptions
  has_many :invoices
  has_many :payments

  def has_cards?
    !user.cards.blank?
  end
end
