$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'todo'
require 'database_cleaner'

RSpec.configure do |config|

  config.before(:suite) do
    ENV['RACK_ENV'] = 'test'
    DatabaseCleaner[:active_record, {connection: Todo::DB.prepare}].strategy = :transaction
    DatabaseCleaner[:active_record, {connection: Todo::DB.prepare}].clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

end
