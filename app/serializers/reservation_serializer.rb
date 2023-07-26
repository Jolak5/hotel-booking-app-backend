class ReservationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :reservation_date, :duration, :hotel

  def hotel
    {
      id: object.hotel.id,
      name: object.hotel.name,
      description: object.hotel.description,
      duration: object.hotel.duration,
      price: object.hotel.price,
      image: get_image(object.hotel)
    }
  end

  def get_image(hotel)
    if hotel.image.attached?
      {
        url: rails_blob_url(hotel.image)
      }
    else
      {
        url: nil
      }
    end
  end
end
