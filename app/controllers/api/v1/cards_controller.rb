class Api::V1::CardsController < ApplicationController
  before_filter :card, :except => [:create, :list]
  def create
    @card = @user.cards.create!(params[:card]) # :stripe_token, :last_four, :type, :expires
    @card.set_stripe_id #unless params[:do_not_set_stripe_id]
  end

  def update
  end

  def destroy
    @card.destroy
  end

  def list
    @cards = @user.cards.valid
  end

  def show 
  end
end
