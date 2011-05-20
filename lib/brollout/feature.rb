class Brollout::Feature

  def initialize(name)
    @name = name
    @active = false
  end

  def name
    @name.to_s
  end

  def activate!
    @active = true
  end

  def deactivate!
    @active = false
  end

  def active?
    @active
  end

end
