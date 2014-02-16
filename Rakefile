#############################
# Build a new world.db

# stdlibs

require 'pp'


# 3rd party libs/gems

require 'logutils'
require 'logutils/db'
require 'worlddb'


BUILD_DIR = "./build"
DATA_DIR  = "."


WORLD_DB_PATH = "#{BUILD_DIR}/world.db"

DB_CONFIG = {
  adapter:  'sqlite3',
  database:  WORLD_DB_PATH
}


task :default => :build


directory BUILD_DIR   # make sure it exists


desc "clean world.db build for release"
task :build => [:clean,:create,:importworld] do
  puts "hello from world.db release build script"
end

task :clean do
  rm WORLD_DB_PATH if File.exists?( WORLD_DB_PATH )
end

task :env => BUILD_DIR do
  pp DB_CONFIG
  ActiveRecord::Base.establish_connection( DB_CONFIG )
  
  ## LogUtils::Logger.root.level = :info
end


desc "create world.db schema"
task :create => :env do
  LogDb.create
  WorldDb.create
end

desc "import world.db seeds from folder '#{DATA_DIR}'"
task :importworld => :env do
  WorldDb.read_setup( 'setups/all', DATA_DIR )
end

task :deleteworld => :env do
  WorldDb.delete!
end

desc 'update world.db'
task :update => [:deleteworld, :importworld] do
  puts 'Done.'
end


desc 'build book (draft version) - The Free World Fact Book - from world.db'
task :book => :env do

  PAGES_DIR = "#{BUILD_DIR}/pages"  # use PAGES_OUTPUT_DIR or PAGES_ROOT ??

  require './scripts/book'

  ## build_book()                # multi-page version
  ## build_book( inline: true )  # all-in-one-page version a.k.a. inline version

  puts 'Done.'
end


desc 'build book (release version) - The Free World Fact Book - from world.db'
task :publish => :env do

  PAGES_DIR = "../book/_pages"  # use PAGES_OUTPUT_DIR or PAGES_ROOT ??

  require './scripts/book'

  ## build_book()                # multi-page version
  ## build_book( inline: true )  # all-in-one-page version a.k.a. inline version

  puts 'Done.'
end


desc 'print versions of gems'
task :about => :env do
  puts ''
  puts 'gem versions'
  puts '============'
  puts "textutils #{TextUtils::VERSION}     (#{TextUtils.root})"
  puts "worlddb   #{WorldDb::VERSION}     (#{WorldDb.root})"

  ## todo - add LogUtils  LogDb ??  - check for .root too
  ## todo - add ConfigUtils ConfUtils ConfDb ??
end


desc 'print stats for world.db tables/records'
task :stats => :env do
  puts ''
  puts 'world.db'
  puts '============'
  WorldDb.tables
end
