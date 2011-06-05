require 'spec_helper'

class TestAdapter
  attr_accessor :strategy

  def initialize
    @active = false
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

describe Brollout::Feature do

  before { Brollout.adapter = TestAdapter.new }
  subject { Brollout::Feature.new(:nifty) }

  it 'has a name' do
    subject.name.should == 'nifty'
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
