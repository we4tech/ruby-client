module SplitIoClient
  class EqualToSetMatcher < SetMatcher
    MATCHER_TYPE = 'EQUAL_TO_SET'.freeze

    attr_reader :attribute

    def initialize(attribute, remote_array)
      super(attribute, remote_array)
    end

    def match?(args)
      set = local_set(args[:attributes], @attribute)
      matches = set == @remote_set
      SplitLogger.log_if_debug("[EqualsToSetMatcher] #{set} equals to #{@remote_set} -> #{matches}");
      matches
    end

    def string_type?
      false
    end
  end
end
