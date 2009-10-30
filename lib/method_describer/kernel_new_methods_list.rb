=begin rdoc
 add method methods2 so that it returns lists that are split into two kind of [adds a marker where the inherited methods begin].
=end
module Kernel
  alias :methods_old :methods
  def methods2 all = true
    if all
      # give some marker designating when the inherited methods start
      (public_methods(false) << :"inherited methods after this point >>") + (public_methods(true) - public_methods(false))
    else
      public_methods(false)
    end
  end
end

if $0 == __FILE__
  class A; end
  puts 'A.methods', A.methods(true).inspect, A.methods(false).inspect
  puts 'A.new.methods', A.new.methods.inspect
end
