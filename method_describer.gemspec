Gem::Specification.new do |s|
  s.name = %q{method_describer}
  s.version = "0.0.2"
 
  s.authors = ["Roger Pack"]
  s.description = s.summary = %q{ruby method describer to make it possible to inspect methods [rdoc, signature, etc.]}
  s.email = ["rogerdpack@gmail.comm"]
  s.files = ["lib/method_desc.rb", "lib/method_describer/class_desc.rb", "lib/method_describer/kernel_new_methods_list.rb", "lib/method_describer/method_desc.rb"]
  s.require_paths = ['lib']
  s.homepage = %q{http://github.com/rogerdpack/desc_methods}
  s.add_dependency(%q<rdoc>, [">= 2.3"])
  s.add_dependency(%q<require_all>, [">= 1.1"])
  s.add_dependency(%q<rogerdpack-arguments>)
  s.add_dependency(%q<ParseTree>) # for 1.8 only
     
end
