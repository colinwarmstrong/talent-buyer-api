class VenueSerializer < ActiveModel::Serializer
  attributes :id, :name, :street_address, :city, :state, :zip, :capacity
end
