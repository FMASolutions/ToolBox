begin
    require 'rugged'
    require 'socket'
rescue LoadError => e
    t = Time.new
    puts t.to_i
else
    environmentpath = ARGV[0]
    environment     = ARGV[1]

    compiling_master = Socket.gethostname

    repo = Rugged::Repository.discover(File.join(environmentpath, environment))
    head = repo.head

    commit_id = head.target_id[0...11]

    puts "#{compiling_master}-#{environment}-#{commit_id}"
end