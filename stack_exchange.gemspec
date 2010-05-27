Gem::Specification.new do |gem|
  gem.name = "stack_exchange"
  gem.version = "0.1.1"
  gem.authors = ["Dalto Curvelano Junior"]
  gem.description = "A ruby wrapper to the StackExchange (StackOverflow and friends) API."
  gem.summary = "A ruby wrapper to the StackExchange (StackOverflow and friends) API."
  gem.files = [
    "stack_exchange.gemspec",
    "lib/stack_exchange/stack_overflow/badge.rb",
    "lib/stack_exchange/stack_overflow/statistics.rb",
    "lib/stack_exchange/stack_overflow/user.rb",
    "lib/stack_exchange.rb",
    "spec/fixtures/badges.json",
    "spec/fixtures/badges_by_id.json",
    "spec/fixtures/badges_by_id_page2.json",
    "spec/fixtures/badges_name.json",
    "spec/fixtures/stats.json",
    "spec/stack_exchange/stack_overflow/badge_spec.rb",
    "spec/stack_exchange/stack_overflow/stack_overflow_spec.rb",
    "spec/stack_exchange/stack_overflow/statistics_spec.rb",
    "spec/stack_exchange/stack_overflow/user_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  gem.homepage = "http://github.com/dlt/stack_exchange"
end
