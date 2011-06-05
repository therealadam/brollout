require 'spec_helper'

describe Brollout::Adapter do

  it 'raises an exception if no strategy is set' do
    expect { subject.active? }.to raise_exception
  end

  it 'raises an exception when an unknown strategy is used' do
    subject.strategy = :wakka_wakka
    expect { subject.active? }.to raise_exception(ArgumentError)
    expect { subject.activate! }.to raise_exception(ArgumentError)
    expect { subject.deactivate! }.to raise_exception(ArgumentError)
  end

  context 'implements the on/off strategy' do
    before { subject.strategy = :on_off }

    it 'is disabled by default' do
      subject.should_not be_active
    end

    it 'activates for all uses' do
      subject.activate!
      subject.should be_active
    end

    it 'deactivates for all uses' do
      subject.activate!
      subject.deactivate!
      subject.should_not be_active
    end
  end

  context 'with the percentage strategy' do
    before { subject.strategy = :percentage }

    it 'is enabled zero percent of the time by default' do
      subject.percentage.should eq(0)
      subject.should_not be_active
    end

    it 'is active if percentage is greater than a random roll' do
      subject.activate_for(100)
      subject.should be_active
    end
  end

  context 'with the per-user strategy' do
    before { subject.strategy = :per_user }
    let(:user) { Object.new }

    it 'defaults to disabled for non-activated users' do
      subject.should_not be_active_for(user)
    end

    it 'is active for activated users' do
      subject.activate_for(user)
      subject.should be_active_for(user)
    end

    it 'is not active for deactivated users' do
      subject.activate_for(user)
      subject.deactivate!(user)
      subject.should_not be_active_for(user)
    end

  end

  context 'with the user-modulo strategy' do
    before { subject.strategy = :user_modulo }
    let(:user) do
      Class.new do
        def id
          49
        end
      end.new
    end

    it 'defaults to zero percent active' do
      subject.should_not be_active_for(user)
    end

    it 'is active if the user ID is greater than the percentage' do
      subject.activate!(user.id + 1)
      subject.should be_active_for(user)
    end

    it 'is not active if the user ID is less than the percentage' do
      subject.activate!(user.id - 1)
      subject.should_not be_active_for(user)
    end

  end

end
