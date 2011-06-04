require 'active_support/core_ext/module'

module Brollout

  autoload :Adapter, 'brollout/adapter'
  autoload :Feature, 'brollout/feature'

  mattr_accessor :adapter

  def self.feature(name, strategy=:on_off, adapter=:default)
    return Feature.new(name, strategy) if adapter == :default
    Feature.new(name, strategy, adapter)
  end

end
