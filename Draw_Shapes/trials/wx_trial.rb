require 'wx'
include Wx

class DrawShapes < Frame
	def initialize
		super(nil, -1, 'Lets Draw Shapes')
		@my_panel = Panel.new(self)
		
		@my_label = StaticText.new(@my_panel, -1, 'My Label Text', 
			DEFAULT_POSITION, DEFAULT_SIZE, ALIGN_CENTER)
		@my_textbox = TextCtrl.new(@my_panel, -1, 'Default Textbox Value')
		@my_combo = ComboBox.new(@my_panel, -1, 'Default Combo Text', 
			DEFAULT_POSITION, DEFAULT_SIZE, ['Item 1', 'Item 2', 'Item 3'])
		@my_button = Button.new(@my_panel, -1, 'My Button Text')
		
		evt_button(@my_button.get_id()) { |event| my_button_click(event)}
		
		@my_panel_sizer = BoxSizer.new(VERTICAL)
		@my_panel.set_sizer(@my_panel_sizer)
		@my_panel_sizer.add(@my_label, 0, GROW|ALL, 2)
		@my_panel_sizer.add(@my_textbox, 0, GROW|ALL, 2)
		@my_panel_sizer.add(@my_combo, 0, GROW|ALL, 2)
		@my_panel_sizer.add(@my_button, 0, GROW|ALL, 2)
		show()
	end
	
	def my_button_click(event)
		# Your code here
	end
end

class MyApp < App
	def on_init
		DrawShapes.new
	end
end

MyApp.new.main_loop()