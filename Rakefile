#############################
# Build a new world.db

$RUBYLIBS_DEBUG = true


# 3rd party libs/gems

require 'worlddb'   ##   todo: just use worlddb/models - why, why not???
require 'logutils/activerecord'   ## add db logging

# our own code

require './settings'     ## e.g. pulls in DATA_DIR (e.g. ../world.db)


##
# output settings

BUILD_DIR     = "./build"
WORLD_DB_PATH = "#{BUILD_DIR}/world.db"

DB_CONFIG = {
  adapter:  'sqlite3',
  database:  WORLD_DB_PATH
}


task :default => :build

directory BUILD_DIR   # make sure it exists



desc "clean world.db build from folder '#{DATA_DIR}'"
task :build => [:clean,:create,:importworld] do
  puts 'Done.'
end

task :clean do
  rm WORLD_DB_PATH if File.exists?( WORLD_DB_PATH )
end

task :env => BUILD_DIR do
  pp DB_CONFIG
  ActiveRecord::Base.establish_connection( DB_CONFIG )

  ## try to speed up sqlite
  ## see http://www.sqlite.org/pragma.html
  c = ActiveRecord::Base.connection
  c.execute( 'PRAGMA synchronous=OFF;' )
  c.execute( 'PRAGMA journal_mode=OFF;' )
  c.execute( 'PRAGMA temp_store=MEMORY;' )

  ## LogUtils::Logger.root.level = :info
end


desc "create world.db schema"
task :create => :env do
  WorldDb.create_all
end


SETUP = ENV['SETUP'] || ENV['DATA'] || 'countries'
puts "  using SETUP >#{SETUP}<"

task :importworld => :env do
  WorldDb.read_setup( "setups/#{SETUP}", DATA_DIR )
end

task :deleteworld => :env do
  WorldDb.delete!
end

desc "update world.db from folder '#{DATA_DIR}'"
task :update => [:deleteworld, :importworld] do
  puts 'Done.'
end



############################################
# add more tasks (keep build script modular)

Dir.glob('./tasks/**/*.rake').each do |r|
  puts " importing task >#{r}<..."
  import r
  # see blog.smartlogicsolutions.com/2009/05/26/including-external-rake-files-in-your-projects-rakefile-keep-your-rake-tasks-organized/
end

