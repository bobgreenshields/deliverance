require 'pathname'
require 'fileutils'
require_relative '../lib/constants'
require_relative '../lib/dir_explorer'

desc "Load demo files"
task :demo do

files = ->(file) do
	target = ROOT_DIR + file.relative_path_from(DEMO_DIR)
	raise StandardError, "File exists #{target}" if target.exist?
	FileUtils.cp(file, target)
end

dirs = ->(dir) do
	target = ROOT_DIR + dir.relative_path_from(DEMO_DIR)
	raise StandardError, "Directory does not exist #{target}" unless dir.exist?
end

exp = DirExplorer.new(on_file: files, on_dir: dirs)
exp.call(DEMO_DIR)

end
