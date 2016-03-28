module NMax
  autoload :VERSION, 'nmax/version'

  def self.get(stream:, n:)
    stream.grep(/\d+/) { |d| d[/(\d+)/, 1].to_i }.sort_by { |a, b| b <=> a }[0..(n - 1)]
  end
end
