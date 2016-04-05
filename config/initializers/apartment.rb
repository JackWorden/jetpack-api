Apartment.configure do |config|
  config.excluded_models = %w(User Team)
  config.tenant_names = -> { Team.select(:name, :id).map(&:schema_name) }
end
