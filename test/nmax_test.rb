require_relative 'test_helper'

describe NMax do
  def nmax(command = '', previous_command: nil)
    `#{previous_command}#{Bundler.root}/bin/nmax #{command}`
  end

  describe 'CLI' do
    it 'shows --version' do
      nmax('--version').must_include NMax::VERSION
    end

    it 'shows --help' do
      nmax('--help').must_include 'nmax'
    end
  end

  describe 'calculation' do
  end
end
