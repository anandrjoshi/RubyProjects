class Book < ActiveRecord::Base
	has_and_belongs_to_many :users, :limit => 1
	validates_presence_of :title
	validates_presence_of :edition
	validates_presence_of :publisher
	validates_presence_of :authors, :message => ":: This book must have been written by at least one author."
	validates_numericality_of :edition, :message => ":: Edition must be an integer and greater than 0.", :only_integer => true, :greater_than => 0

	def self.search(title)
    if title != nil
      title_like = "%" + title + "%"
      find(:all, :conditions => ['title LIKE ?', title_like])
    end
  end

end
