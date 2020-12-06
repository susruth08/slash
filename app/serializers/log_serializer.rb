class LogSerializer
  include FastJsonapi::ObjectSerializer
  
  attribute :previous_version do |object|
    YAML.load(object.previous_version)
  end

  attribute :id do |object|
    object.id
  end

  attribute :status do |object|
    object.status
  end

  attribute :next_version do |object|
    YAML.load(object.next_version)
  end
  

  attribute :admin_email do |object|
    object.log.user.email
  end


end
