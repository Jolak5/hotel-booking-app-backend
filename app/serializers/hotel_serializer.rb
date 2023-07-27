class HotelSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :name, :description, :duration, :price, :image

  def image
    Rails.logger.debug "Serializing image for hotel: #{object.id}"
    if object.image.attached?
      {
        url: rails_blob_url(object.image, host: 'https://hotel-booking-7djb.onrender.com/')
      }
    else
      {
        url: nil
      }
    end
  end
end
