class Api::V1::SubscriptionsController < ApplicationController
  before_filter :subscription, :except => [:list, :create]
  before_filter :store, :only => [:create]
  before_filter :card, :only => [:create]
  def list
    @subscriptions = @user.subscriptions
  end

  def show
  end

  def create
    @subscription = @user.subscriptions.new(params[:subscription]) #amount, description, frequency, next_due, :currency
    @store.subscriptions << @subscription
    @card.subscriptions << @subscription
    @subscription.save
    @subscription.check
  end

  def update
  end

  def destroy
    @subscription.destroy
    # send webhook
  end
end
