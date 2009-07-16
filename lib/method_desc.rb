# originally gleaned from http://p.ramaze.net/17901
require 'rubygems'
require 'rdoc'
require 'rdoc/ri/driver'

module SourceLocationDesc
  # add a Method#desc which reads off the method's rdocs if any exist
  # 1.9 only
  def desc want_output = false
    doc = [to_s, "arity: #{arity}"]
    if respond_to? :source_location
      file, line = source_location
    end
    if file
      # then it's a pure ruby method
      head_and_sig = File.readlines(file)[0...line]
      sig = head_and_sig[-1]
      head = head_and_sig[0..-2]

      # needs more sophistication, but well... :)
      head.reverse_each do |line|
        break unless line =~ /^\s*#(.*)/
        doc.unshift $1.strip
      end
    else
      doc << 'Binary method or you\'re not in 1.9'
    end

    if respond_to? :parameters
      prog_sig = "Programmatic signature: %s %p" % [name, parameters]
      orig_sig = "Original signature: %s" % sig.to_s.strip
      puts [prog_sig, orig_sig, ''] + doc
    else
      puts doc
    end

    # now default RI for the same:
    # to_s is something like "#<Method: String#strip>"
    to_s =~ /ethod: (.*)>/
    begin
      RDoc::RI::Driver.run [$1]
    rescue SystemExit
     # not found
    end
    doc if want_output
  end
end

class Method; include SourceLocationDesc; end
class UnboundMethod; include SourceLocationDesc; end


class Object
  # currently rather verbose, but will attempt to describe all it knows about a method
  def method_desc name
    if self.is_a? Class
       # i.e. String.strip
       instance_method(name).desc
    else
       method(name).desc
    end
  end
end

if $0 == __FILE__
  require 'pathname'
  puts "=" * 80
  puts Pathname.instance_method(:children).desc
  puts "=" * 80
  puts Pathname.instance_method(:ftype).desc
  puts "=" * 80
  # now some binaries:
  puts ''.method_desc :strip
  puts String.method_desc :strip
end

=begin 
>> require 'pathname'
doctest:
 it should display the name
>> Pathname.instance_method(:children).desc(true).grep(/children/)
=>  ["#<UnboundMethod: Pathname#children>"]

 and arity
>> Pathname.instance_method(:children).desc(true).grep(/arity/)
=>  ["arity: -1"]

# todo: one that is guaranteed to exit you early [no docs at all ever]

=end
