require 'set'

class Brollout::Adapter

  attr_writer :strategy

  def initialize
    @strategy = nil

    @active = false
    @active_users = Set.new
    @percentage = 0
  end

  def activate!(arg={})
    case strategy
    when :percentage
      @percentage = arg
    when :per_user
      @active_users << arg
    when :user_modulo
      @percentage = arg
    when :on_off
      @active = true
    else
      raise ArgumentError.new("Unknown strategy '#{strategy}'")
    end
  end
  alias :activate_for :activate!

  def deactivate!(arg={})
    case strategy
    when :per_user
      @active_users.delete(arg)
    when :on_off
      @active = false
    else
      raise ArgumentError.new("Unknown strategy '#{strategy}'")
    end
  end

  def active?(arg={})
    case strategy
    when :percentage
      active_for_percentage?
    when :per_user
      active_for_user?(arg)
    when :user_modulo
      active_for_user_modulo?(arg)
    when :on_off
      @active
    else
      raise ArgumentError.new("Unknown strategy '#{strategy}'")
    end
  end
  alias :active_for? :active?

  def active_for_percentage?
    percentage > rand(100)
  end

  def percentage
    @percentage
  end

  def active_for_user?(user)
    @active_users.include?(user)
  end

  def active_for_user_modulo?(user)
    percentage > user.id
  end

  def strategy
    raise 'You must specify a strategy before using a feature.' if @strategy.nil?
    @strategy
  end

end
