class HotelSerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :duration, :price, :image
  
    def image
      if object.image.attached?
        {
          url: rails_blob_url(object.image)
        }
      end
    end
  end
  