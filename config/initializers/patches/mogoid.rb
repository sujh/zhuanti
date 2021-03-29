# modify mongoid's serialize way:
# e.g "_id": {"$oid":"5858d7a5c8d39c2016331723"} => “id”: “5858d7a5c8d39c2016331723”
module Mongoid
  module Document
    def as_json(options={})
      attrs = super(options)
      attrs["_id"] = attrs["_id"]["$oid"].to_s
      attrs["created_at"] = created_at.to_s if respond_to?(:created_at)
      attrs["updated_at"] = updated_at.to_s if respond_to?(:updated_at)
      attrs
    end
  end
end