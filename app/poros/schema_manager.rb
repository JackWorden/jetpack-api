class SchemaManager
  def initialize(team)
    @team = team
  end

  def switch
    Apartment::Tenant.switch!(schema_name)
  end

  def create_schema
    Apartment::Tenant.create(schema_name)
  end

  def drop_schema
    Apartment::Tenant.drop(schema_name)
  end

  def schema_name
    "#{@team.name}_#{@team.id}"
  end
end
