 class Api::V1::InvoicesController < ApplicationController
  before_filter :invoice, :except => [:create, :list]
  before_filter :store, :only => [:create]
  require "stripe"
  Stripe.api_key = "sk_test_DoXPXUXZSn0F8jg1ccNvUsV6"
  def list
    @invoices = @user.invoices #order by due, then refunds, then successful
   end

  def show
  end

  def create
    @invoice = @user.invoices.create!(params[:invoice])
    @store.invoices << @invoice
  end

  def update
  end

  def destroy
    payment = Stripe::Charge.retrieve(@invoice.payment.stripe_id)
    payment.refund
    @invoice.payment.destroy
    @invoice.status = 'refunded'
    @invoice.save
  end
end
