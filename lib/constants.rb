require 'pathname'

ROOT_DIR = Pathname.new(__FILE__).parent.expand_path.parent
AREAS_DIR = ROOT_DIR + '_areas'
ROSTERS_DIR = ROOT_DIR + '_rosters'
ASSETS_DIR = ROOT_DIR + 'assets'
DEMO_DIR = ROOT_DIR + 'demo'
BACKUP_DIR = ROOT_DIR + 'bak'
