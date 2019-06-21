require 'yaml'

class YamlLoader
	def call(file_name)
		YAML.load_file(file_name)
	end

end

class Party
	def initialize(file_name, loader: YamlLoader.new)
		@data = loader.call(file_name)
	end

	def names
		@data["names"]
	end

	def add_name(name)
		names << name
	end

	def rows
		@data["rows"]
	end

	def categories
		rows.map { | row | row["category"] }
	end

	def values(category)
		@data["rows"].select { |hash| hash["category"] == category }.first["values"]
	end

	def add_value(category:, value:)
	  values(category) << value	
	end

	def to_yaml
		@data.to_yaml
	end

end
