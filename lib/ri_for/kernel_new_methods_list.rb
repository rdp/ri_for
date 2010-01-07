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

class Object
 def my_methods(_super=false)
   _methods = (_super) ? self.class.superclass.new.methods : Object.methods
   (self.methods - _methods).sort
 end
end