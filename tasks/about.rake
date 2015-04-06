

desc 'print versions of gems'
task :about do
  puts ''
  puts 'gem versions'
  puts '============'
  puts "props     #{ConfUtils::VERSION}     (#{ConfUtils.root})"
  puts "logutils  #{LogKernel::VERSION}     (#{LogKernel.root})"
  puts "textutils #{TextUtils::VERSION}     (#{TextUtils.root})"
  puts "tagutils  #{TagUtils::VERSION}     (#{TagUtils.root})"
  puts "worlddb   #{WorldDb::VERSION}     (#{WorldDb.root})"

  ## todo - add LogUtils  LogDb ??  - check for .root too
end

