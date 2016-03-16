json.array!(@apartments) do |apartment|
  json.extract! apartment, :id, :address, :name, :contact, :longitude, :latitude
  json.url apartment_url(apartment, format: :json)
end
