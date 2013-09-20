class Invoice < ActiveRecord::Base
  attr_accessible :amount, :card_id, :currency, :description, :status, :store_id, :user_id, :created_at
  # set status default to due.
  has_one :payment
  belongs_to :user
  belongs_to :store
  belongs_to :subscription

  require "stripe"
  Stripe.api_key = "sk_test_DoXPXUXZSn0F8jg1ccNvUsV6"

  def refunded?
    self.status == 'refunded'
  end

  def paid?
    !self.payment.blank?
  end

  def due?
    !self.paid? && !self.refunded?
  end



  def refunds
    self.where :status => 'refunded' #turn into scope
  end

  def successful_payments
    self.map { |x| x if x.paid? }
  end

  def due_payments
    self.map { |x| x if x.due? } #change
  end



  def amount_due
    self.amount * self.store.rate / 100
  end

  def due_since
    self.created_at if self.due? #humanize
  end

  

  def pay_with card
    return {} if self.paid?

    customer = Stripe::Customer.retrieve(self.user.stripe_id)
    stripe_card = customer.cards.retrieve(card.stripe_id)
    customer.default_card = stripe_card.id

    charge = Stripe::Charge.create(
      :amount => self.amount_due,
      :currency => self.currency,
      :customer => customer.id,
      :description => self.description
    )

    return "error here" unless charge.paid
    payment = self.user.payments.create!(:stripe_id => charge.id)
    self.payment = payment
    self.store.payments << payment
    card.payments << payment
    return payment
  end
end
