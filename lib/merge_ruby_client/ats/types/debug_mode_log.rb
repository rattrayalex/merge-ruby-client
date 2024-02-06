# frozen_string_literal: true

require_relative "debug_model_log_summary"
require "json"

module Merge
  module Ats
    class DebugModeLog
      attr_reader :log_id, :dashboard_view, :log_summary, :additional_properties

      # @param log_id [String]
      # @param dashboard_view [String]
      # @param log_summary [Ats::DebugModelLogSummary]
      # @param additional_properties [OpenStruct] Additional properties unmapped to the current class definition
      # @return [Ats::DebugModeLog]
      def initialize(log_id:, dashboard_view:, log_summary:, additional_properties: nil)
        # @type [String]
        @log_id = log_id
        # @type [String]
        @dashboard_view = dashboard_view
        # @type [Ats::DebugModelLogSummary]
        @log_summary = log_summary
        # @type [OpenStruct] Additional properties unmapped to the current class definition
        @additional_properties = additional_properties
      end

      # Deserialize a JSON object to an instance of DebugModeLog
      #
      # @param json_object [JSON]
      # @return [Ats::DebugModeLog]
      def self.from_json(json_object:)
        struct = JSON.parse(json_object, object_class: OpenStruct)
        parsed_json = JSON.parse(json_object)
        log_id = struct.log_id
        dashboard_view = struct.dashboard_view
        if parsed_json["log_summary"].nil?
          log_summary = nil
        else
          log_summary = parsed_json["log_summary"].to_json
          log_summary = Ats::DebugModelLogSummary.from_json(json_object: log_summary)
        end
        new(log_id: log_id, dashboard_view: dashboard_view, log_summary: log_summary, additional_properties: struct)
      end

      # Serialize an instance of DebugModeLog to a JSON object
      #
      # @return [JSON]
      def to_json(*_args)
        { "log_id": @log_id, "dashboard_view": @dashboard_view, "log_summary": @log_summary }.to_json
      end

      # Leveraged for Union-type generation, validate_raw attempts to parse the given hash and check each fields type against the current object's property definitions.
      #
      # @param obj [Object]
      # @return [Void]
      def self.validate_raw(obj:)
        obj.log_id.is_a?(String) != false || raise("Passed value for field obj.log_id is not the expected type, validation failed.")
        obj.dashboard_view.is_a?(String) != false || raise("Passed value for field obj.dashboard_view is not the expected type, validation failed.")
        Ats::DebugModelLogSummary.validate_raw(obj: obj.log_summary)
      end
    end
  end
end
