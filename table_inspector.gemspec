require_relative "lib/table_inspector/version"

Gem::Specification.new do |spec|
  spec.name        = "table_inspector"
  spec.version     = TableInspector::VERSION
  spec.authors     = ["ian"]
  spec.email       = ["ianlynxk@gmail.com"]
  spec.homepage    = "https://github.com/table_inspector"
  spec.summary     = "Inspect table structure of ActiveRecord class"
  spec.description = "Inspect table structure of ActiveRecord class"
  spec.license     = "MIT"
  
  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/otorain/table_inspector"
  spec.metadata["changelog_uri"] = "https://github.com/otorain/table_inspector/CHANGELOG"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.0.3.0"
end
