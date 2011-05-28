require 'spec_helper'

describe Brollout do

  context '.storage' do

    it 'sets the default adapter' do
      dummy = double
      Brollout.adapter = dummy
      Brollout.adapter.should eq(dummy)
    end

  end

  context '.feature' do

    it 'creates a new on/off feature' do
      feature = Brollout.feature(:thingy)
      feature.name.should eq('thingy')
      feature.strategy.should eq(:on_off)
    end

    it 'creates a new feature with the specified strategy' do
      feature = Brollout.feature(:thingy, :random)
      feature.name.should eq('thingy')
      feature.strategy.should eq(:random)
    end

    it 'creates a new feature with the specified strategy and adapter' do
      adapter = double
      feature = Brollout.feature(:thingy, :random, adapter)
      feature.name.should eq('thingy')
      feature.strategy.should eq(:random)
      feature.adapter.should eq(adapter)
    end

  end

  context '.register_strategy' do

    it 'adds a named strategy' do
      pending('figure out how this should work')
      Brollout.register_strategy(:custom) do |user|
        user.admin?
      end
    end

  end

end
