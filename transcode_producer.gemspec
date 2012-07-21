
Gem::Specification.new do |gem|
  gem.name = "transcode_producer"
  gem.version = "0.0.1"
  gem.homepage = "http://github.com/rgeyer/transcode_producer"
  gem.license = "MIT"
  gem.summary = %Q{Fetches videos from an RSS feed, and creates transcoding jobs in an AMQP queue}
  gem.description = gem.summary
  gem.email = "me@ryangeyer.com"
  gem.authors = ["Ryan J. Geyer"]
  gem.executables << 'transcode_producer'

  gem.add_dependency('bunny', '~> 0.7')
  gem.add_dependency('fog', '~> 1.3')
  gem.add_dependency('trollop', '~> 1.16')
  gem.add_dependency('simple-rss', '~> 1.2')
  gem.add_dependency('json', '~> 1.7')

  gem.files = Dir.glob("lib/**/*") + ["LICENSE.txt", "README.rdoc"]
end