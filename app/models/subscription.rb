class Subscription < ActiveRecord::Base
  attr_accessible :amount, :card_id, :description, :frequency, :next_due, :store_id, :user_id, :currency

  has_many :invoices
  belongs_to :user
  belongs_to :store
  belongs_to :card

  def check
    if due_today?
      create_invoice_from_subscription
      @invoice.pay_with self.card
      self.set_next_due
    end
  end

  def create_invoice_from_subscription
    @invoice = self.invoices.new
    @invoice.amount = self.amount
    @invoice.currency = self.currency
    @invoice.description = self.description
    @invoice.save
    @invoice.store = self.store
    @invoice.user = self.user
    @invoice.card = self.card
  end

  def set_next_due
    self.next_due += self.frequency
    self.save
  end

  def due_today?
    self.next_due <= 86400 #payment is today
  end

end
