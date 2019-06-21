require 'pathname'
require 'tty-prompt'
#require 'yaml'
require_relative '../lib/party'

PARTY_PATH = Pathname.new(Rake.original_dir) + '_data' + 'party.yml'

desc "Add a new character to the party page"
task :add_char do
	prompt = TTY::Prompt.new

#	puts Pathname.new(Rake.original_dir)
#	puts PARTY_PATH
	

	unless PARTY_PATH.exist?
		puts "FAILED: cannot find #{PARTY_PATH}"
		exit
	end

  party = Party.new(PARTY_PATH)
	if party.names.length > 0 then
		puts "The party already contains #{party.names.join(", ")}"
	else
		puts "There are currently no characters in the party"
	end

	name =  prompt.ask("What is the character's name? (single word)") do | q |
		q.required true
	end
	party.add_name name

	party.categories.each do | category |
		value =  prompt.ask("What is #{name}'s #{category}?") do | q |
			q.required true
		end
		party.add_value(category: category, value: value)
	end

	backup = Time.now.strftime("#{PARTY_PATH}.%Y%m%d%k%M%S")
	puts "Backing up the old file to #{backup}"

	PARTY_PATH.rename(backup)
	puts "Writing new file"
	PARTY_PATH.write(party.to_yaml)
	puts "SUCCESS: #{name} has been added to the party"

end
#	area.number = prompt.ask('What is the area number?') do | q |
#		q.required true
#		q.validate /^\d+$/
#	end
#
#	area.title =	prompt.ask('What is the area title?') do | q |
#		q.required true
#	end
#
#	area.description = prompt.ask('What is the area description (optional)?',
#		default: "")
#
#	while area.ask_for_leads_to? do
#		response =  prompt.ask( \
#			'Enter the number of an area that this one leads to (enter for none or to finish)?')
#		if response.nil? || response.match(/^\d+$/)
#			area.add_leads_to response
#		else
#			puts "#{response.strip} is invalid, please enter a number or press the enter key to finish"
#			next
#		end
#	end
#
#	while area.ask_for_player_image? do
#		area.add_player_image prompt.ask( \
#			'Enter the name of a player image (enter for none or to finish)?',
#			default: "")
#	end
#
#	areas_dir = Pathname.new(Rake.original_dir) + "_areas"
#	unless areas_dir.directory?
#		puts "FAILED: cannot find the _areas directory"
#		exit
#	end
#
#	file_path = areas_dir + area.filename
#	if file_path.exist?
#		puts "FAILED: the area file #{file_path} already exists"
#		exit
#	else
#		file_path.write(area.to_yaml)
#		puts "SUCCESS: the area file #{file_path.basename} has been made"
#	end
