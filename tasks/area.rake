require 'pathname'
require 'tty-prompt'
require 'yaml'
require_relative '../lib/area'


desc "Create a new area"
task :area do
	prompt = TTY::Prompt.new
	area = Area.new

	area.number = prompt.ask('What is the area number?') do | q |
		q.required true
		q.validate /^\d+$/
	end

	area.title =	prompt.ask('What is the area title?') do | q |
		q.required true
	end

	area.description = prompt.ask('What is the area description (optional)?',
		default: "")

	while area.ask_for_leads_to? do
		response =  prompt.ask( \
			'Enter the number of an area that this one leads to (enter for none or to finish)?')
		if response.nil? || response.match(/^\d+$/)
			area.add_leads_to response
		else
			puts "#{response.strip} is invalid, please enter a number or press the enter key to finish"
			next
		end
	end

	while area.ask_for_player_image? do
		area.add_player_image prompt.ask( \
			'Enter the name of a player image (enter for none or to finish)?',
			default: "")
	end

	areas_dir = Pathname.new(Rake.original_dir) + "_areas"
	unless areas_dir.directory?
		puts "FAILED: cannot find the _areas directory"
		exit
	end

	file_path = areas_dir + area.filename
	if file_path.exist?
		puts "FAILED: the area file #{file_path} already exists"
		exit
	else
		file_path.write(area.to_yaml)
		puts "SUCCESS: the area file #{file_path.basename} has been made"
	end
end
