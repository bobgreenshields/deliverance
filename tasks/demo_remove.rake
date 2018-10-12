require 'pathname'
require_relative '../lib/constants'
require_relative '../lib/dir_explorer'

desc "Remove demo files"
task :remove_demo do

files = ->(file) do
	target = ROOT_DIR + file.relative_path_from(DEMO_DIR)
	if target.exist?
		target.delete
	else
		puts "#{target} doesn't exist, cannot delete"
	end
end

dirs = ->(dir) do
	target = ROOT_DIR + dir.relative_path_from(DEMO_DIR)
	raise StandardError, "Directory does not exist #{target}" unless dir.exist?
end

exp = DirExplorer.new(on_file: files, on_dir: dirs)
exp.call(DEMO_DIR)

end
