require 'pathname'
require_relative 'constants'
require_relative 'dir_explorer'

module Utils
	module_function

	def sanitise(name)
		name.strip.downcase.gsub(/[^a-z0-9\.]+/,"-").gsub(/-\./, ".")
	end

	def notify_exit(response)
			puts "\e[91mFAILED\e[0m: shell cmd: #{response.cmd}"
			puts response
			exit 100
	end

	def init_dir
		dirs = ->(dir) do
			target = ROOT_DIR + dir.relative_path_from(DEMO_DIR)
			target.mkdir unless dir.exist?
		end

		exp = DirExplorer.new(on_dir: dirs)
		exp.call(DEMO_DIR)
	end

end
