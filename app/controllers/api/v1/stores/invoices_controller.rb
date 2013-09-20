class Api::V1::Stores::InvoicesController < ApplicationController
  skip_before_filter :auth
  before_filter :auth_store
  def show
    @invoice = @store.invoices.find(params[:invoice_id])
  end

  def list
    @invoices = @store.invoices
  end
end
