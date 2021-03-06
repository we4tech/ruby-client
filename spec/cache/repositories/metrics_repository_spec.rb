# frozen_string_literal: true

require 'spec_helper'

describe SplitIoClient::Cache::Repositories::MetricsRepository do
  RSpec.shared_examples 'metrics specs' do |cache_adapter|
    let(:adapter) { cache_adapter }
    let(:repository) { described_class.new(adapter) }
    let(:binary_search) { SplitIoClient::BinarySearchLatencyTracker.new }

    before :each do
      Redis.new.flushall
    end

    it 'does not return zero latencies' do
      repository.add_latency('foo', 0, binary_search)

      expect(repository.latencies.keys).to eq(%w[foo])
    end
  end

  include_examples 'metrics specs', SplitIoClient::Cache::Adapters::RedisAdapter.new(
    SplitIoClient::SplitConfig.default_redis_url
  )
end
