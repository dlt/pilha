Gem::Specification.new do |gem|
  gem.name = "pilha"
  gem.version = "0.1.6"
  gem.authors = ["Dalto Curvelano Junior"]
  gem.description = "A ruby wrapper to the Stack Exchange (Stack Overflow and friends) API."
  gem.summary = "A ruby wrapper to the Stack Exchange (Stack Overflow and friends) API."
  fixture_files = Dir["spec/fixtures/*"]
  gem.files = [
    "pilha.gemspec",
    "lib/pilha.rb",
    "lib/pilha/stack_overflow/badge.rb",
    "lib/pilha/stack_overflow/statistics.rb",
    "lib/pilha/stack_overflow/user.rb",
    "lib/pilha/stack_overflow/comment.rb",
    "lib/pilha/stack_overflow/answer.rb",
    "lib/pilha/stack_overflow/question.rb",
    "lib/pilha/stack_overflow/base.rb",
    "spec/pilha/stack_overflow/badge_spec.rb",
    "spec/pilha/stack_overflow/stack_overflow_spec.rb",
    "spec/pilha/stack_overflow/statistics_spec.rb",
    "spec/pilha/stack_overflow/user_spec.rb",
    "spec/pilha/stack_overflow/comment_spec.rb",
    "spec/pilha/stack_overflow/answer_spec.rb",
    "spec/pilha/stack_overflow/question_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    *fixture_files
  ]
  gem.homepage = "http://github.com/dlt/pilha"
end
