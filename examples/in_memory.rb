#!/usr/bin/env ruby

require 'brollout'

Brollout.adapter = Brollout::Adapter.new

missiles = Brollout.feature(:missiles)
missiles.activate! if ENV['ACTIVATE']

if missiles.active?
  puts "Missiles launched."
else
  puts "Missiles idle."
end

puts 'Have a nice day!'
