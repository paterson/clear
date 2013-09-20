class Store::TransactionsController < ApplicationController
  before_filter :authenciate_store!
  before_filter :get_store, :only => [:create, :list]
  before_filter :get_transaction, :except => [:create, :list, :edit]
  def list
    @transactions = @store.transactions
  end

  def show
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
    #refund
    @transaction.status = 'refunded'
    @transaction.save
    # tell user
  end
end
