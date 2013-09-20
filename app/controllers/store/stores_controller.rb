class Store::StoresController < ApplicationController
  before_filter :authenciate_store!
  before_filter :get_store, :except => [:list, :new, :create]
  def list
    @store = current_store
  end

  def show
    @store = current_store
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  def destroy
    @store.destroy
    #redirect with flash
  end
end
