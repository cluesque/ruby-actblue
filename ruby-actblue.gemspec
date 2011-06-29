Gem::Specification.new do |s|
  s.name = "ruby-actblue"
  s.version = "0.0.2"
  s.date = "2009-02-17"
  s.summary = "Library for accessing the ActBlue API."
  s.email = "kyle.shank@gmail.com"
  s.homepage = "http://github.com/netroots/ruby-actblue"
  s.authors = ["Kyle Shank", "Nathan Woodhull" ]
  s.files = [Dir.glob("{bin,lib}/**/*") + %w(README.textile)]
  s.has_rdoc = false
  s.add_dependency("httparty", [">= 0.7.3"])
  
  s.add_development_dependency "ruby-debug19"
  s.add_development_dependency "rspec", "~>1.3"
end