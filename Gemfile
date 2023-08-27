source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in table_inspector.gemspec.
gemspec

group :test do
  gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
  gem "rspec"
  gem "rspec-rails"
  gem 'simplecov', require: false, group: :test
end

gem "sqlite3"


# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
