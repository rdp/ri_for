=begin rdoc
 Supplement [monkey patch] the existing #methods call so that it now has an optional parameter
 and also returns lists that are more helpful.
=end
module Kernel
 alias :methods_old :methods
 def methods all = true
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
