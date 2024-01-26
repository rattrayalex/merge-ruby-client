# frozen_string_literal: true

module Merge
  module Crm
    # @type [Hash{String => String}]
    CARDINALITY_ENUM = {
      one_to_one: "ONE_TO_ONE",
      many_to_one: "MANY_TO_ONE",
      many_to_many: "MANY_TO_MANY",
      one_to_many: "ONE_TO_MANY"
    }.frozen
  end
end
