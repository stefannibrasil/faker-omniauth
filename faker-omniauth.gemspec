Gem::Specification.new do |s|
  s.name        = "faker-omniauth"
  s.version     = "0.0.0"
  s.summary     = "Generate fake Omniauth response from Microsoft provider"
  s.description = "Exploring adding external generators to faker ruby"
  s.authors     = ["Stefanni Brasil"]
  s.files       = ["lib/faker-omniauth.rb"]

  s.required_ruby_version = '>= 3.5'

  s.add_dependency "faker"
end
