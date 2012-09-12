require "rubygame"
include Rubygame

maximum_resolution = Screen.get_resolution
puts "This display can manage at least " + maximum_resolution.join("x")