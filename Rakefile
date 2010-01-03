require 'jeweler'
Jeweler::Tasks.new do |s|
  s.name = %q{ri_for}
  s.authors = ["Roger Pack"]
  s.description = s.summary = %q{ruby method describer to make it possible to inspect methods [rdoc, signature, etc.] at runtime, for example while debugging.}
  s.email = ["rogerdpack@gmail.comm"]

  s.homepage = %q{http://github.com/rogerdpack/method_describer}
  s.add_dependency(%q<rdoc>, [">= 2.3"]) # for sane ri lookup times
  s.add_dependency(%q<rdp-require_all>, [">= 1.1.0.1"]) # require_rel
  s.add_dependency(%q<rdp-arguments>, [">= 0.6.4"])
  s.add_dependency(%q<sane>, ['>= 0.1.2'])
  s.add_dependency(%q<ParseTree>) # these next two for 1.8 only...
  s.add_dependency(%q<ruby2ruby>)
  s.add_development_dependency("rubydoctest")
end

