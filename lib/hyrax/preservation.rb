if defined? Rails
  require "hyrax/preservation/engine"
  require 'hyrax'
end

module Hyrax
  module Preservation
    def self.root
      Pathname.new(File.expand_path('../../../', __FILE__))
    end
  end
end
