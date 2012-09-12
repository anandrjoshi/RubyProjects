require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'active_support/inflector'
require "./Word_Class.rb"
require "./Database_Connection.rb"


add_another_word = true
while add_another_word == true
	system('cls')
	puts "Enter the word you would like to enter:"
	spell = gets.chomp.lstrip.rstrip.capitalize
	
	begin
		new_word = Word.new(:spell => spell)
		new_word.save!
		puts "Word added successfully."
	rescue => exception
		puts exception
	end
	
	puts "Do you wish to add another word (yes\\no)?"
	continue = gets.chomp.lstrip.rstrip.capitalize
	if continue == "No"
		add_another_word = false
	end
end	

puts" Words in the game are:"

records = Word.all()
	records.each{|record| puts record.spell}
	
	