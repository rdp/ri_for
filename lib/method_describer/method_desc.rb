# originally gleaned from http://p.ramaze.net/17901
require 'rubygems'
require 'rdoc'
require 'rdoc/ri/driver'
begin
  gem 'arguments' # TODO why is this necessary?
  require 'arguments' # rogerdpack-arguments
rescue LoadError
  require 'arguments' # 1.9
end

module SourceLocationDesc
  # add a Method#desc which reads off the method's rdocs if any exist
  # 1.9 only
  def desc want_output = false, want_one_liner = false
    doc = []

    # to_s is something like "#<Method: String#strip>"
    to_s =~ /ethod: ((.*)#(.*))>/
    full_name = $1
    class_name = $2
    method_name = $3


    # now default RI for the same:
    begin
      RDoc::RI::Driver.run [full_name, '--no-pager'] unless want_one_liner
    rescue SystemExit
      # not found
    end


    # now gather up any other information we now about it, in case there are no rdocs

    if !(respond_to? :source_location)
      # pull out names for 1.8
      begin
        args = Arguments.names( eval(class_name), method_name)
        return args if want_one_liner
        doc << args
      rescue Exception 
        puts "please install the ParseTree gem"
      end
    else
      file, line = source_location
      if file
        # then it's a pure ruby method
        head_and_sig = File.readlines(file)[0...line]
        sig = head_and_sig[-1]
        head = head_and_sig[0..-2]
        return sig + "\n" + head[0] if want_one_liner

        # needs more sophistication, but well... :)
        head.reverse_each do |line|
          break unless line =~ /^\s*#(.*)/
          doc.unshift "     " + $1.strip
        end
      else
        doc << 'binary method (c)'
      end
    end

    if respond_to? :parameters
      prog_sig = "Signature from #parameters: %s %p" % [name, parameters]
      orig_sig = "Original code signature: %s" % sig.to_s.strip
      doc = [prog_sig, orig_sig, ''] + doc
    end
    # put arity at the end
    doc += [to_s, "arity: #{arity}"]
    puts doc

    doc if want_output
  end
  named_args_for :desc
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
  alias :desc_method :method_desc # you can have it either way
end

=begin 
doctest:
>> require 'pathname'
it should display the name
>> Pathname.instance_method(:children).desc(:want_output => true).grep(/children/).size > 0
=>  true # ["#<UnboundMethod: Pathname#children>"]

and arity
>> Pathname.instance_method(:children).desc(:want_output => true).grep(/arity/)
=>  ["arity: -1"]

# todo: one that is guaranteed to exit you early [no docs at all ever]

=end
