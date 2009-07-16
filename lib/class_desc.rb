require './method_desc'
class Object
  # just runs ri against the class
  def desc
    begin
      RDoc::RI::Driver.run [to_s, '--no-pager']
    rescue SystemExit
      # not found
    end
    doc = []
    doc << "non inherited methods:" + instance_methods(false).inspect
    doc << "ancestors:" + (ancestors - String.ancestors).inspect
    
  end

end

=begin
doctest:

it should return true if you run it against a "real" class
>> String.desc.length > 1
=> true
>> class A; end
>> A.desc.length > 1
=>  true

it shouldn't report itself as an ancestor
>> A.desc.grep(/ancestors/).include? '[A]'
=> false
=end
