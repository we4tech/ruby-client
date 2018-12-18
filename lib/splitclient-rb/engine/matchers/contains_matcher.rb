module SplitIoClient
  class ContainsMatcher
    MATCHER_TYPE = 'CONTAINS_WITH'.freeze

    attr_reader :attribute

    def initialize(attribute, substr_list)
      @attribute = attribute
      @substr_list = substr_list
    end

    def match?(args)
      SplitLogger.log_if_debug("[ContainsMatcher] evaluating value and attributes.");
      return false if !args.key?(:attributes) && !args.key?(:value)
      return false if args.key?(:value) && args[:value].nil?
      return false if args.key?(:attributes) && args[:attributes].nil?

      value = args[:value] || args[:attributes].fetch(@attribute) do |a|
        args[:attributes][a.to_s] || args[:attributes][a.to_sym]
      end
      SplitLogger.log_if_debug("[ContainsMatcher] Value from parameters: #{value}.");
      return false if @substr_list.empty?

      matches = @substr_list.any? { |substr| value.to_s.include? substr }
      SplitLogger.log_if_debug("[ContainsMatcher] #{@value} contains any of #{@substr_list} -> #{matches} .");
      matches
    end

    def string_type?
      true
    end
  end
end
