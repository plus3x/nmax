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

  it 'should not load file to process memory' do
    file = Tempfile.new('tmp')
    file.write(('0'..'z').to_a.*(50_000).sample(1_000_000).join)
    file.rewind

    starting_memory = memstats

    NMax.get(stdin: file, count: 5)

    assert memstats < starting_memory + 6000, 'Calculation has consumed more than 6MB'
  end
end
