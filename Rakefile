require 'pathname'

Dir.glob('tasks/*.rake').each { |r| import r}

#look for ip task
search_dir = Pathname.pwd
2.times do
	search_dir = search_dir.parent
	ip_task_file = search_dir + "tasks" + "ip.rake"
	if ip_task_file.exist?
		import ip_task_file
	end
end
