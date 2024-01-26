# frozen_string_literal: true
require_relative "engagement_type_activity_type"
require "date"
require "date"
require_relative "remote_field"
require "json"

module Merge
  module Crm
    # # The Engagement Type Object 
### Description

The `Engagement Type` object is used to represent an interaction activity. A given `Engagement` typically has an `Engagement Type` object represented in the engagement_type field.

### Usage Example

TODO
    class EngagementType
      attr_reader :activity_type, :name, :id, :remote_id, :created_at, :modified_at, :remote_fields, :additional_properties
      # @param activity_type [Crm::EngagementTypeActivityType] The engagement type's activity type.  - `CALL` - CALL
- `MEETING` - MEETING
- `EMAIL` - EMAIL
      # @param name [String] The engagement type's name.
      # @param id [String] 
      # @param remote_id [String] The third-party API ID of the matching object.
      # @param created_at [DateTime] 
      # @param modified_at [DateTime] This is the datetime that this object was last updated by Merge
      # @param remote_fields [Array<Crm::RemoteField>] 
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Crm::EngagementType]
      def initialize(activity_type: nil, name: nil, id: nil, remote_id: nil, created_at: nil, modified_at: nil, remote_fields: nil, additional_properties: nil)
        # @type [Crm::EngagementTypeActivityType] The engagement type's activity type. 
- `CALL` - CALL
- `MEETING` - MEETING
- `EMAIL` - EMAIL
        @activity_type = activity_type
        # @type [String] The engagement type's name.
        @name = name
        # @type [String] 
        @id = id
        # @type [String] The third-party API ID of the matching object.
        @remote_id = remote_id
        # @type [DateTime] 
        @created_at = created_at
        # @type [DateTime] This is the datetime that this object was last updated by Merge
        @modified_at = modified_at
        # @type [Array<Crm::RemoteField>] 
        @remote_fields = remote_fields
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end
      # Deserialize a JSON object to an instance of EngagementType
      #
      # @param json_object [JSON] 
      # @return [Crm::EngagementType]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        activity_type = struct.activity_type.to_h.to_json()
        activity_type = Crm::EngagementTypeActivityType.from_json(json_object: activity_type)
        name = struct.name
        id = struct.id
        remote_id = struct.remote_id
        created_at = DateTime.parse(struct.created_at)
        modified_at = DateTime.parse(struct.modified_at)
        remote_fields = struct.remote_fields.map() do | v |
  v = v.to_h.to_json()
  Crm::RemoteField.from_json(json_object: v)
end
        new(activity_type: activity_type, name: name, id: id, remote_id: remote_id, created_at: created_at, modified_at: modified_at, remote_fields: remote_fields, additional_properties: struct)
      end
      # Serialize an instance of EngagementType to a JSON object
      #
      # @return [JSON]
      def to_json
        { "activity_type": @activity_type, "name": @name, "id": @id, "remote_id": @remote_id, "created_at": @created_at, "modified_at": @modified_at, "remote_fields": @remote_fields }.to_json()
      end
      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object] 
      # @return [Void]
      def self.validate_raw(obj:)
        obj.activity_type.nil?() || Crm::EngagementTypeActivityType.validate_raw(obj: obj.activity_type)
        obj.name&.is_a?(String) != false || raise("Passed value for field obj.name is not the expected type, validation failed.")
        obj.id&.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.remote_id&.is_a?(String) != false || raise("Passed value for field obj.remote_id is not the expected type, validation failed.")
        obj.created_at&.is_a?(DateTime) != false || raise("Passed value for field obj.created_at is not the expected type, validation failed.")
        obj.modified_at&.is_a?(DateTime) != false || raise("Passed value for field obj.modified_at is not the expected type, validation failed.")
        obj.remote_fields&.is_a?(Array) != false || raise("Passed value for field obj.remote_fields is not the expected type, validation failed.")
      end
    end
  end
end