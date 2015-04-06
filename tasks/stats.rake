

desc 'print stats for world.db tables/records'
task :stats => :env do
  puts ''
  puts 'world.db'
  puts '============'
  WorldDb.tables
end

