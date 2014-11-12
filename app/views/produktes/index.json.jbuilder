json.array!(@produktes) do |produkte|
  json.extract! produkte, :id, :name, :beschreibung, :preis, :stueckzahl, :datumvon, :datumbis
  json.url produkte_url(produkte, format: :json)
end
