class Api::V1::PaymentsController < ApplicationController
  before_filter :payment, :except => [:list, :create]
  before_filter :invoice, :only => [:create]
  before_filter :card, :only => [:create]
  def list
    @payments = @user.payments
  end

  def show
  end

  def create
    @payment = @invoice.pay_with @card
  end

  def update
  end

  def destroy
    payment = Stripe::Charge.retrieve(@payment.stripe_id)
    payment.refund
    @payment.destroy
  end
end
