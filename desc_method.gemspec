Gem::Specification.new do |s|
  s.name = %q{desc_method}
  s.version = "0.1.5"
  s.authors = ["Roger Pack"]
  s.description = s.summary = %q{ruby method describer to make it possible to inspect methods [rdoc, signature, etc.] at runtime, for example while debugging.}
  s.email = ["rogerdpack@gmail.comm"]
  s.files = ["README", "lib/desc_method.rb", "lib/method_describer/class_desc.rb", "lib/method_describer/kernel_new_methods_list.rb", "lib/method_describer/method_desc.rb"]
  s.require_paths = ['lib']

  s.homepage = %q{http://github.com/rogerdpack/method_describer}
  s.add_dependency(%q<rdoc>, [">= 2.3"]) # for sane ri lookup times
  s.add_dependency(%q<require_all>, [">= 1.1"]) # require_rel
  s.add_dependency(%q<rogerdpack-arguments>)
  s.add_dependency(%q<rogerdpack-sane>, ['>= 0.1.2'])
  s.add_dependency(%q<ParseTree>) # these next two for 1.8 only
  s.add_dependency(%q<ruby2ruby>)
end

# 0.1.
     #4 say searching ri for cause it takes forever...
     #4 finally work for rails-y methods
# 0.1.3 return something useful instead of nil
# 0.1.2 fix bug
# 0.1.1 minor cleanups on 1.9 [for release]
# 0.1.0 First release yea!
# 0.0.8 add class_desc, and make less verbose
# 0.0.7 fix bugs in display source for class methods, add test [we have tests now!]
# 0.0.6 same, add source almost.
# 0.0.5 Attempt to handle class methods, as well
 
