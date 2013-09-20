class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :auth

  def invoice
    @invoice = @user.invoices.find_by_id(params[:invoice_id]) #hack
    render 'api/v1/404' if !@invoice
  end

  def payment
    @payment = @user.payments.find_by_id(params[:payment_id])
    render 'api/v1/404' if !@payment
  end

  def card
    @card = @user.cards.find_by_id(params[:card_id])
    render 'api/v1/404' if !@card
  end

  def store
    @store = Store.find_by_id(params[:store_id])
    render 'api/v1/404' if !@store
  end

  def subscription
    @subscription = @user.subscriptions.find_by_id(params[:subscription_id])
    render 'api/v1/404' if !@subscription
  end

  def auth
    if params[:token]
      @user = User.find_by_authentication_token(params[:token])
    else
      @user = User.find_by_email(params[:email]) 
      @user = nil if @user && !@user.valid_password?(params[:password])
    end
    render "api/v1/unauthorized" if !@user
  end

  def auth_store
    @store = Store.find_by_authentication_token(params[:token])
    render "api/v1/unauthorized" if !@store
  end

end
