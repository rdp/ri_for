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

  # add a Method#desc which spits out all it knows about that method
  # ri, location, local ri, etc.
  # TODO does this work with class methods?
  def desc want_just_summary = false
    doc = []

    # to_s is something like "#<Method: String#strip>"
    # or #<Method: GiftCertsControllerTest(Test::Unit::TestCase)#get>
    string = to_s

    if string.include? '('
      # case #<Method: GiftCertsControllerTest(Test::Unit::TestCase)#get>
      string =~ /\((.*)\)/ # extract out what is between parentheses for the classname
      class_name = $1
    else
      # case "#<Method: String#strip>"
      string =~ /Method: (.*)#>/
      class_name = $1
    end

    string =~ /Method: .*#(.*)>/
    method_name = $1
    full_name = "#{class_name}##{method_name}"

    # now run default RI for it
    begin
      puts 'ri for ' + full_name
      RDoc::RI::Driver.run [full_name, '--no-pager'] unless want_just_summary
    rescue SystemExit
      # not found
    end


    # now gather up any other information we now about it, in case there are no rdocs

    if !(respond_to? :source_location)
      # pull out names for 1.8
      begin
        args = Arguments.names( eval(class_name), method_name)
        doc << "parameters:" + args.join(',')
        return args if want_just_summary
      rescue Exception => e
        puts "please install the ParseTree gem #{e}"
      end
    else
      file, line = source_location
      if file
        # then it's a pure ruby method
        head_and_sig = File.readlines(file)[0...line]
        sig = head_and_sig[-1]
        head = head_and_sig[0..-2]

        # needs more sophistication, but well... :)
        head.reverse_each do |line|
          break unless line =~ /^\s*#(.*)/
          doc.unshift "     " + $1.strip
        end
        return sig + "\n" + head[0] if want_just_summary
      else
        doc << 'appears to be a binary method (c)'
      end
    end

    if respond_to? :parameters
      prog_sig = "Signature from #parameters: %s %p" % [name, parameters]
      orig_sig = "Original code signature: %s" % sig.to_s.strip
      doc = [prog_sig, orig_sig, ''] + doc
    end
    # put arity at the end
    doc += [to_s, "arity: #{arity}"]
    puts doc # always output it since RI does currently [todo]

    doc # give them something they can examine
  end

  named_args_for :desc # just for fun, tests use it too, plus it should actually wurk without interfering...I think

end

class Method; include SourceLocationDesc; end
class UnboundMethod; include SourceLocationDesc; end

# TODO mixin a separate module
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
