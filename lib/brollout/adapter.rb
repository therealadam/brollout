require 'set'

class Brollout::Adapter

  def initialize
    @active = false
    @active_users = Set.new
    @percentage = 0
  end

  def activate!(strategy, arg={})
    case strategy
    when :percentage
      @percentage = arg
    when :per_user
      @active_users << arg
    when :user_modulo
      @percentage = arg
    else
      @active = true
    end
  end
  alias :activate_for :activate!

  def deactivate!(strategy, arg={})
    case strategy
    when :per_user
      @active_users.delete(arg)
    else
      @active = false
    end
  end

  def active?(strategy, arg={})
    case strategy
    when :percentage
      active_for_percentage?
    when :per_user
      active_for_user?(arg)
    when :user_modulo
      active_for_user_modulo?(arg)
    else
      @active
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

end
