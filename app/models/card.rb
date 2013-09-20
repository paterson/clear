class Card < ActiveRecord::Base
  belongs_to :user
  has_many :subscriptions
  has_many :payments

  attr_accessible :card_type, :last_four, :expires, :stripe_id, :user_id, :stripe_token, :name

  scope :valid, where("expires >= ?",Time.now.to_i)

  require "stripe"
  Stripe.api_key = "sk_test_DoXPXUXZSn0F8jg1ccNvUsV6"

  def expired?
    self.expires < Time.now.to_i
  end

  def set_stripe_id
    customer = Stripe::Customer.retrieve(self.user.stripe_id)
    card = customer.cards.create(:card => self.stripe_token)
    customer.default_card = card.id
    self.stripe_id = card.id
    self.save
  end

end
