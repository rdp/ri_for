# from http://p.ramaze.net/17901


module SourceLocationDesc
  # add a Method#desc which reads off the method's rdocs if any exist
  # 1.9 only
  def desc
    file, line = source_location
    *head, sig = File.readlines(file)[0...line]
    doc = []

    # needs more sophistication, but well... :)
    head.reverse_each do |line|
      break unless line =~ /^\s*#(.*)/
      doc.unshift $1.strip
    end

    prog_sig = "Programmatic signature: %s %p" % [name, parameters]
    orig_sig = "Original signature: %s" % sig.strip
    [prog_sig, orig_sig, ''] + doc
  end
end

class Method; include SourceLocationDesc; end
class UnboundMethod; include SourceLocationDesc; end

if $0 == __FILE__
  require 'pathname'
  puts "=" * 80
  puts Pathname.instance_method(:children).desc
  puts "=" * 80
  puts Pathname.instance_method(:ftype).desc
  puts "=" * 80
end
