Gem::Specification.new do |s|
  s.name         = 'colir'
  s.version      = File.read('VERSION')
  s.date         = Time.now.strftime('%Y-%m-%d')
  s.summary      = 'Colir means colour in Ukrainan. In Ruby it means HEX colour'
  s.description  = 'This library is about HEX colours.'
  s.author       = 'Kyrylo Silin'
  s.email        = 'kyrylosilin@gmail.com'
  s.homepage     = 'https://github.com/kyrylo/colir'
  s.licenses     = 'zlib'

  s.require_path = 'lib'
  s.files        = `git ls-files`.split("\n")

  s.add_development_dependency 'bacon'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'pry'
end
