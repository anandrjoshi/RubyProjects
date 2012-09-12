#require "./Database_Connection.rb"

class Word < ActiveRecord::Base
	validates_presence_of :spell
	validates_uniqueness_of :spell
	validates_format_of :spell, :with => /\A(^[a-zA-Z]{7,40})\Z/i
	
  #begin
	#Word.new
  #rescue => ex
	#puts "Table to store word information does not exist. Cannot proceed further."
	#exit
  #end
end
