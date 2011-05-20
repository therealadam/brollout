require 'spec_helper'

describe Brollout::Feature do

  subject { Brollout::Feature.new(:extra_violence) }

  it 'has a name' do
    subject.name.should == 'extra_violence'
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
