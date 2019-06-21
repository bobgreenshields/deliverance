class DirExplorer

	def initialize(on_file: ->(file) {}, on_dir: ->(dir) {}, recursive: true)
		@on_file = on_file
		@on_dir = on_dir
		@recursive = recursive
	end

	def clone
		self.class.new(on_file: @on_file, on_dir: @on_dir, recursive: @recursive)
	end

	def call(root)
		root.each_child do |child|
			if child.directory?
				@on_dir.call(child)
				self.clone.call(child) if @recursive
			elsif child.file?
				@on_file.call(child)
			else
			end
		end
	end	

end
