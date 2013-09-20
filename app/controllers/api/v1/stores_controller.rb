class Api::V1::StoresController < ApplicationController
  skip_before_filter :auth
  before_filter :store
  def show
  end
end
