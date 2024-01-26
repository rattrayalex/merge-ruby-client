# frozen_string_literal: true

require_relative "issue_status"
require "date"
require "json"

module Merge
  module Crm
    class Issue
      attr_reader :id, :status, :error_description, :end_user, :first_incident_time, :last_incident_time, :is_muted,
                  :error_details, :additional_properties

      # @param id [String]
      # @param status [Crm::IssueStatus] Status of the issue. Options: ('ONGOING', 'RESOLVED')  - `ONGOING` - ONGOING
      `RESOLVED`
      # @param error_description [String]
      # @param end_user [Hash{String => String}]
      # @param first_incident_time [DateTime]
      # @param last_incident_time [DateTime]
      # @param is_muted [Boolean]
      # @param error_details [Array<String>]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Crm::Issue]
      def initialize(error_description:, id: nil, status: nil, end_user: nil, first_incident_time: nil,
                     last_incident_time: nil, is_muted: nil, error_details: nil, additional_properties: nil)
        # @type [String]
        @id = id
        # @type [Crm::IssueStatus] Status of the issue. Options: ('ONGOING', 'RESOLVED')
        `ONGOING`
        `RESOLVED`
        @status = status
        # @type [String]
        @error_description = error_description
        # @type [Hash{String => String}]
        @end_user = end_user
        # @type [DateTime]
        @first_incident_time = first_incident_time
        # @type [DateTime]
        @last_incident_time = last_incident_time
        # @type [Boolean]
        @is_muted = is_muted
        # @type [Array<String>]
        @error_details = error_details
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of Issue
      #
      # @param json_object [JSON]
      # @return [Crm::Issue]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        id = struct.id
        status = struct.status.to_h.to_json
        status = Crm::IssueStatus.from_json(json_object: status)
        error_description = struct.error_description
        end_user = struct.end_user
        first_incident_time = DateTime.parse(struct.first_incident_time)
        last_incident_time = DateTime.parse(struct.last_incident_time)
        is_muted = struct.is_muted
        error_details = struct.error_details
        new(id: id, status: status, error_description: error_description, end_user: end_user,
            first_incident_time: first_incident_time, last_incident_time: last_incident_time, is_muted: is_muted, error_details: error_details, additional_properties: struct)
      end

      # Serialize an instance of Issue to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        {
          "id": @id,
          "status": @status,
          "error_description": @error_description,
          "end_user": @end_user,
          "first_incident_time": @first_incident_time,
          "last_incident_time": @last_incident_time,
          "is_muted": @is_muted,
          "error_details": @error_details
        }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.id&.is_a?(String) != false || raise("Passed value for field obj.id is not the expected type, validation failed.")
        obj.status.nil? || Crm::IssueStatus.validate_raw(obj: obj.status)
        obj.error_description.is_a?(String) != false || raise("Passed value for field obj.error_description is not the expected type, validation failed.")
        obj.end_user&.is_a?(Hash) != false || raise("Passed value for field obj.end_user is not the expected type, validation failed.")
        obj.first_incident_time&.is_a?(DateTime) != false || raise("Passed value for field obj.first_incident_time is not the expected type, validation failed.")
        obj.last_incident_time&.is_a?(DateTime) != false || raise("Passed value for field obj.last_incident_time is not the expected type, validation failed.")
        obj.is_muted&.is_a?(Boolean) != false || raise("Passed value for field obj.is_muted is not the expected type, validation failed.")
        obj.error_details&.is_a?(Array) != false || raise("Passed value for field obj.error_details is not the expected type, validation failed.")
      end
    end
  end
end
