require 'yaml'

class Area

	def initialize
		@player_images = []
		@leads_tos = []
	end

	def number=(value)
		@number = value.to_i
	end

	def title=(value)
		@title = value.strip
	end

	def description=(value)
		@description = value.strip
	end

	def sanitise(value)
		value.to_s.strip.downcase.gsub(/[^a-z0-9\.]+/,"-").gsub(/-\./, ".")
	end

	def add_leads_to(leads_to)
		if leads_to.nil?
			@leads_tos << ""
		else
			@leads_tos << leads_to.to_i.to_s
		end
	end

	def ask_for_leads_to?
		@leads_tos.length == 0 || !(@leads_tos.last == "")
	end

	def add_player_image(image_name)
		@player_images << sanitise(image_name)
	end

	def ask_for_player_image?
		@player_images.length == 0 || !(@player_images.last == "")
	end

	def file_prefix
		@number < 10 ? "0#{@number}" : @number.to_s
	end

	def filename
		"#{file_prefix}-#{sanitise(@title)}.md"
	end

	def to_yaml
		res = {}
		@leads_tos.pop if (!@leads_tos.empty? && @leads_tos.last == "")
		@player_images.pop if (!@player_images.empty? && @player_images.last == "")
		res["layout"] = "area"
		res["number"] = @number.to_s
		res["title"] = @title
		res["description"] = @description if @description.length > 0
		res["leads_to"] = @leads_tos if @leads_tos.length > 0
		res["player_images"] = @player_images if @player_images.length > 0
		res["categories"] = "area"
		res.to_yaml + "---"
	end
end
