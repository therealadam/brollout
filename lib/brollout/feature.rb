class Brollout::Feature

  def initialize(name, strategy=:on_off, adapter=Brollout.adapter)
    @name = name
    @adapter = adapter
    adapter.strategy = strategy
  end

  def name
    @name.to_s
  end

  def adapter
    @adapter
  end

  def activate!
    @adapter.activate!
  end

  def deactivate!
    @adapter.deactivate!
  end

  def active?
    @adapter.active?
  end

end
