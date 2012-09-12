def select_display_hangman(level)
	
	case level
		when 0
			disp_level0_man()
		when 1
			disp_level1_man()
		when 2
			disp_level2_man()
		when 3
			disp_level3_man()
		when 4
			disp_level4_man()
		when 5
			disp_level5_man()
		when 6
			disp_level6_man()
		else
			disp_level0_man()		
	end	
end

def disp_level0_man
	puts"\t\t\t\t."
	puts "\t\t     +----------+-"
	puts "\t\t     |          |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t     ====================="
end

def disp_level1_man
	puts "\t\t\t\t."
	puts "\t\t     +----------+-"
	puts "\t\t     |          |"
	puts "\t\t     -          |"
	puts "\t\t    | |         |"
	puts "\t\t     -          |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t     ====================="
end

def disp_level2_man
	puts "\t\t\t\t."
	puts "\t\t     +----------+-"
	puts "\t\t     |          |"
	puts "\t\t     -          |"
	puts "\t\t    | |         |"
	puts "\t\t     -          |"
	puts "\t\t     +          |"
	puts "\t\t    -|-         |"
	puts "\t\t     |          |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t     ====================="
end

def disp_level3_man
	puts "\t\t\t\t."
	puts "\t\t     +----------+-"
	puts "\t\t     |          |"
	puts "\t\t     -          |"
	puts "\t\t    | |         |"
	puts "\t\t     -          |"
	puts "\t\t     +          |"
	puts "\t\t    -|-         |"
	puts "\t\t   / |          |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t     ====================="
end

def disp_level4_man
	puts "\t\t\t\t."
	puts "\t\t     +----------+-"
	puts "\t\t     |          |"
	puts "\t\t     -          |"
	puts "\t\t    | |         |"
	puts "\t\t     -          |"
	puts "\t\t     +          |"
	puts "\t\t    -|-         |"
	puts "\t\t   / | \\        |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t\t                |"
	puts "\t     ====================="
end

def disp_level5_man
	puts "\t\t\t\t."
	puts "\t\t     +----------+-"
	puts "\t\t     |          |"
	puts "\t\t     -          |"
	puts "\t\t    | |         |"
	puts "\t\t     -          |"
	puts "\t\t     +          |"
	puts "\t\t    -|-         |"
	puts "\t\t   / | \\        |"
	puts "\t\t     ^          |"
	puts "\t\t    /           |"
	puts "\t\t   /            |"
	puts "\t\t  /             |"
	puts "\t\t                |"
	puts "\t     ====================="
end

def disp_level6_man
	puts "\t\t\t\t."
	puts "\t\t     +----------+-"
	puts "\t\t     |          |"
	puts "\t\t     -          |"
	puts "\t\t    | |         |"
	puts "\t\t     -          |"
	puts "\t\t     +          |"
	puts "\t\t    -|-         |"
	puts "\t\t   / | \\        |"
	puts "\t\t     ^          |"
	puts "\t\t    / \\         |"
	puts "\t\t   /   \\        |"
	puts "\t\t  /     \\       |"
	puts "\t\t                |"
	puts "\t     ====================="
end
