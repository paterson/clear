class Api::V1::UsersController < ApplicationController
  require "stripe"
  Stripe.api_key = "sk_test_DoXPXUXZSn0F8jg1ccNvUsV6"
  def update
  end

  def destroy
    @user.destroy
  end

  def list
    #@users = User.all
  end

  def show
    @user = User.find_by_email(params[:email])
    if @user.valid_password?(params[:password])
      @user.reset_authentication_token! if @user.reset_token
      sign_in('user',@user)
    else
      render 'api/v1/users/error'
    end
  end

  def create
    @user = User.new
    @user.email = params[:email]
    @user.password = params[:password]
    if @user.save
      client = Stripe::Customer.create(
        :email => @user.email
      )
      @user.stripe_id = client.id
      @user.reset_authentication_token!
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
end
