Gem::Specification.new do |gem|
  gem.name = "pilha"
  gem.version = "0.1.2"
  gem.authors = ["Dalto Curvelano Junior"]
  gem.description = "A ruby wrapper to the Stack Exchange (Stack Overflow and friends) API."
  gem.summary = "A ruby wrapper to the Stack Exchange (Stack Overflow and friends) API."
  gem.files = [
    "pilha.gemspec",
    "lib/pilha/stack_overflow/badge.rb",
    "lib/pilha/stack_overflow/statistics.rb",
    "lib/pilha/stack_overflow/user.rb",
    "lib/pilha/stack_overflow/comment.rb",
    "lib/pilha/stack_overflow/answer.rb",
    "lib/pilha.rb",
    "spec/fixtures/stats.json",
    "spec/fixtures/stats.json.gz",
    "spec/fixtures/badges.json",
    "spec/fixtures/badges.json.gz",
    "spec/fixtures/badges_by_id.json",
    "spec/fixtures/badges_by_id.json.gz",
    "spec/fixtures/badges_by_id_page2.json",
    "spec/fixtures/badges_by_id_page2.json.gz",
    "spec/fixtures/badges_tag_based.json",
    "spec/fixtures/badges_tag_based.json.gz",
    "spec/fixtures/answers_by_id.json",
    "spec/fixtures/answers_by_id.json.gz",
    "spec/fixtures/answer_with_comments.json",
    "spec/fixtures/answer_with_comments.json.gz",
    "spec/fixtures/comments.json",
    "spec/fixtures/comments.json.gz",
    "spec/fixtures/users_answers.json",
    "spec/fixtures/users_answers.json.gz",
    "spec/pilha/stack_overflow/badge_spec.rb",
    "spec/pilha/stack_overflow/stack_overflow_spec.rb",
    "spec/pilha/stack_overflow/statistics_spec.rb",
    "spec/pilha/stack_overflow/user_spec.rb",
    "spec/pilha/stack_overflow/comment_spec.rb",
    "spec/pilha/stack_overflow/answer_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb"
  ]
  gem.homepage = "http://github.com/dlt/pilha"
end
