class Payment < ActiveRecord::Base
  attr_accessible :card_id, :country, :ip, :local_time, :stripe_id, :store_id, :user_id, :invoice_id
  belongs_to :user
  belongs_to :store
  belongs_to :card
  belongs_to :invoice

  after_create :get_ip_and_country
  after_create :get_local_time

  def get_ip_and_country
    #@geoip ||= GeoIP.new("#{Rails.root}/datfiles/GeoIP.dat")
    #country = @geoip.country(request.remote_ip)
    #self.ip = request.remote_ip
    #self.country = country.country_name
    #self.save
  end

  def get_local_time

  end
end
