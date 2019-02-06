# frozen_string_literal: true

module NMax
  autoload :VERSION, 'nmax/version'

  class << self
    def get(stdin:, count:, method: :faster)
      send(method, stdin: stdin, count: count)
    end

    private

    def beautiful(stdin:, count:)
      chars = stdin.each_char
      grouped_numbers = chars.chunk { |c| c =~ /\d/ }

      numbers = grouped_numbers.inject([]) do |memo, (_, digits)|
        memo << digits.join.to_i
        memo = memo.sort.last(count) if memo.size > count
        memo
      end

      numbers.sort.last(count)
    end

    # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    def faster(stdin:, count:)
      number_str = String.new # rubocop:disable Performance/UnfreezeString
      numbers = []

      stdin.each_char do |c|
        if c =~ /\d/ # rubocop:disable Performance/RegexpMatch
          number_str << c
        elsif !number_str.empty?
          numbers << number_str.to_i
          numbers = numbers.sort.last(count) if numbers.size > count
          number_str.clear
        end
      end

      numbers << number_str.to_i unless number_str.empty?

      numbers.sort.last(count)
    end
    # rubocop:enable Metrics/AbcSize,Metrics/MethodLength
  end
end
