class Brollout::Feature

  def initialize(name, strategy=:on_off, adapter=Brollout.adapter)
    @name = name
    @strategy = strategy
    @adapter = adapter
  end

  def name
    @name.to_s
  end

  def strategy
    @strategy
  end

  def adapter
    @adapter
  end

  def activate!
    @adapter.activate!(@strategy)
  end

  def deactivate!
    @adapter.deactivate!(@strategy)
  end

  def active?
    @adapter.active?(@strategy)
  end

end
