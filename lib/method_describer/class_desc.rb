require_rel 'method_desc'
class Object
  # just runs ri against the class, outputs a big
  def desc return_stuff = false
    begin
      puts "RI for #{to_s}"
      RDoc::RI::Driver.run [to_s, '--no-pager']
    rescue SystemExit
      # not found
    end

    class_methods = methods(false)
    for ancestor in ancestors[1..-1] # skip the first one, which is yourself
      class_methods -= ancestor.methods(false)
    end

    doc = []
    doc << ''
    doc += ["non inherited methods:", instance_methods(false).sort.join(", ")]
    doc += ['non inherited class methods:', class_methods.sort.join(', ')]
    doc += ["ancestors:", ancestors.join(', ')]
    doc += ["Constants (possible sub classes):",  constants.join(', ')] if constants.length > 0
    puts doc
    doc if return_stuff
  end

end

=begin
doctest:

it should return true if you run it against a "real" class
>> String.desc(true).length > 1
=> true
>> class A; end
>> A.desc(true).length > 1
=>  true

it shouldn't report itself as an ancestor
>> A.desc(true).grep(/ancestors/).include? '[A]'
=> false

also lists constants
>> A.desc(true).grep(/constants/)
=> [] # should be none since we didn't add any constants to A
>> A.class_eval { A = 3 }
>> A.desc(true).grep(/constants/).length
=> 1 # should be none since we didn't add any constants to A


=end
