# frozen_string_literal: true

require_relative 'test_helper'
require 'tempfile'

describe NMax do
  it 'should get 2 max numbers from readed file' do
    assert_equal `cat #{Bundler.root}/test/fixtures/text_with_numbers.txt | #{Bundler.root}/bin/nmax 2}`, "22\n30\n"
  end

  def memstats
    `ps -o rss= #{Process.pid}`.strip.to_i
  end

  def should_alllocate_less_then_killobytes(size = 1000)
    file = Tempfile.new('tmp')
    file.write(('0'..'z').to_a.*(50_000).sample(1_000_000).join)
    file.rewind

    starting_memory = memstats

    yield(file, count = 5)

    consumed_memory = memstats - starting_memory

    assert consumed_memory < size, "Calculation has consumed more than #{size}KB(#{consumed_memory}KB)"
  end

  describe 'faster' do
    it 'should not load file to process memory' do
      # Calculated statistically
      allocation_size =
        case RUBY_VERSION.to_f
        when 2.1 then 8000
        when 2.2 then 5000
        when 2.3 then 3000
        when 2.4 then 1100
        when 2.5 then 2300
        when 2.6 then 2100
        end

      should_alllocate_less_then_killobytes(allocation_size) do |file, count|
        NMax.get(stdin: file, count: count, method: :faster)
      end
    end
  end

  describe 'beautiful' do
    it 'should not load file to process memory' do
      # Calculated statistically
      allocation_size =
        case RUBY_VERSION.to_f
        when 2.1 then 7500
        when 2.2 then 4500
        when 2.3 then 3000
        when 2.4 then 1200
        when 2.5 then 2100
        when 2.6 then 2600
        end

      should_alllocate_less_then_killobytes(allocation_size) do |file, count|
        NMax.get(stdin: file, count: count, method: :beautiful)
      end
    end
  end
end
