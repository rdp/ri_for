require_rel 'method_desc'
class Class
  # just runs ri against the class, outputs a big
  def desc_class options = {}
    # want_output = false, verbose = false
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
    doc += ["Constants (possible sub classes):",  constants.join(', ')] if constants.length > 0 && options[:verbose]
    puts doc
    doc if options[:want_output]
  end

end

=begin
doctest:

it should return true if you run it against a "real" class
>> String.desc_class(:want_output => true).length > 1
=> true
>> class A; end
>> A.desc_class(:want_output => true).length > 1
=>  true

it shouldn't report itself as an ancestor of itself
>> A.desc_class(:want_output => true).grep(/ancestors/).include? '[A]'
=> false

also lists constants
>> A.desc_class(:want_output => true, :verbose => true).grep(/constants/i)
=> [] # should be none since we didn't add any constants to A
>> class A; B = 3; end
>> A.desc_class(:want_output => true, :verbose => true).grep(/constants/i).length
=> 1 # should be none since we didn't add any constants to A

should work with sub methods
>> String.desc_method(:strip)

doctest_require: '../method_desc'
=end
