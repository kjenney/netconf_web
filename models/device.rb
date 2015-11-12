class Device
  include Mongoid::Document
  include Mongoid::Timestamps::Updated

  field :name, type: String
  field :description, type: String
  field :ip, type: String
  field :serial, type: String
  field :model, type: String
  field :updated, type: String
end
