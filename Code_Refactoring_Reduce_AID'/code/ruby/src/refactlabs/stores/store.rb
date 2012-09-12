module Refactlabs
  module Stores 
    class Store
	  attr_accessor :name
	
	  def self.descendants
	    children = []
		ObjectSpace.each_object(Class) do |klass|
		children = children << klass if klass < self
	    end
		children
	 end
    end
  end
end
