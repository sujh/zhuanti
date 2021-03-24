class Topic
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::Attributes::Dynamic
  field :data, type: Hash
  field :published, type: :boolean, default: true
end