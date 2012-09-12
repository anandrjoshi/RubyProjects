begin
  ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'assign_1.db')
rescue 
    puts "Unable to connect to the mentioned adaptor. Cannot continue further."
    exit
end
