Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

ENV['RAILS_ENV'] = 'test'

require_relative '../spec/dummy/config/environment'
ENV['RAILS_ROOT'] ||= "#{File.dirname(__FILE__)}../../../spec/dummy"

ActiveRecord::Migrator.migrations_paths = [File.expand_path("../spec/dummy/db/migrate", __dir__)]
ActiveRecord::Migration.maintain_test_schema!