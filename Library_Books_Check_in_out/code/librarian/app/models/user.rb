class User < ActiveRecord::Base
	has_and_belongs_to_many :books
	validates_presence_of :first_name
	validates_presence_of :last_name
	validates_uniqueness_of :last_name, :scope => :first_name, :message => "::Author with entered name already exists."
	validates_format_of :first_name, :with => /\A(^[a-zA-Z'.]{1,40})\Z/i
	validates_format_of :last_name, :with => /\A(^[a-zA-Z'.]{1,40})\Z/i

	def self.search(first_name, last_name)
    if first_name != nil and last_name != nil
      first_name_like = "%" + first_name + "%"
      last_name_like = "%" + last_name + "%"
      find(:all, :conditions => ['first_name LIKE ? AND last_name LIKE ?', first_name_like, last_name_like])
    end
  end

end
