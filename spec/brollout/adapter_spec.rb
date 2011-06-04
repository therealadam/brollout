require 'spec_helper'

describe Brollout::Adapter do

  context 'implements the on/off strategy' do
    let(:strategy) { :on_off }

    it 'is disabled by default' do
      subject.should_not be_active(strategy)
    end

    it 'activates for all uses' do
      subject.activate!(strategy)
      subject.should be_active(strategy)
    end

    it 'deactivates for all uses' do
      subject.activate!(strategy)
      subject.deactivate!(strategy)
      subject.should_not be_active(strategy)
    end
  end

  context 'with the percentage strategy' do
    let(:strategy) { :percentage }

    it 'is enabled zero percent of the time by default' do
      subject.percentage.should eq(0)
      subject.should_not be_active(:percentage)
    end

    it 'is active if percentage is greater than a random roll' do
      subject.activate_for(strategy, 100)
      subject.should be_active(:percentage)
    end
  end

  context 'with the per-user strategy' do
    let(:strategy) { :per_user }
    let(:user) { Object.new }

    it 'defaults to disabled for non-activated users' do
      subject.should_not be_active_for(strategy, user)
    end

    it 'is active for activated users' do
      subject.activate_for(strategy, user)
      subject.should be_active_for(strategy, user)
    end

    it 'is not active for deactivated users' do
      subject.activate_for(strategy, user)
      subject.deactivate!(strategy, user)
      subject.should_not be_active_for(strategy, user)
    end

  end

  context 'with the user-modulo strategy' do
    let(:strategy) { :user_modulo }
    let(:user) do
      Class.new do
        def id
          49
        end
      end.new
    end

    it 'defaults to zero percent active' do
      subject.should_not be_active_for(strategy, user)
    end

    it 'is active if the user ID is greater than the percentage' do
      subject.activate!(strategy, user.id + 1)
      subject.should be_active_for(strategy, user)
    end

    it 'is not active if the user ID is less than the percentage' do
      subject.activate!(strategy, user.id - 1)
      subject.should_not be_active_for(strategy, user)
    end

  end

end
