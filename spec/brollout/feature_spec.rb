require 'spec_helper'

class TestAdapter

  def initialize
    @active = false
  end

  def activate!(strategy)
    @active = true
  end

  def deactivate!(strategy)
    @active = false
  end

  def active?(strategy)
    @active
  end

end

describe Brollout::Feature do

  before { Brollout.adapter = TestAdapter.new }
  subject { Brollout::Feature.new(:nifty) }

  it 'has a name' do
    subject.name.should == 'nifty'
  end

  it 'has a strategy' do
    subject.strategy.should eq(:on_off)
  end

  it 'activates a feature' do
    subject.activate!

    subject.should be_active
  end

  it 'deactivates a feature' do
    subject.activate!
    subject.deactivate!

    subject.should_not be_active
  end

end
