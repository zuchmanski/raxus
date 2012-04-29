spec = Gem::Specification.new do |s|
  s.name = 'raxus'
  s.version = '0.1.1'
  s.has_rdoc = false
  s.summary = 'Easy file sharing with rack'
  s.description = s.summary
  s.author = 'sebcioz'
  s.email = 'sebcioz@gmail.com'
  s.homepage    = 'http://github.com/sebcioz/raxus'
  s.executables = ['raxus']
  s.test_files = Dir.glob('spec/*_spec.rb')
  s.add_dependency('rack', '>= 1.1.0')
  s.add_dependency('thin', '>= 1.2.0')
  s.add_dependency('rubyzip', '>= 0.9.4')
  s.files = %w(LICENCE README.markdown) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
end
