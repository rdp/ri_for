require 'ffi'
class A
 # a suh-weet rdoc
 def go(a=5)
  a = 33
 end

 def self.go2(b=5)
   b = 3
 end
end
=begin
doctest_require: '../lib/ri_for'
>> $VERBOSE = true
>> output = A.ri_for(:go, :want_the_description_returned => true).join(' ')
>> output.include? 'a = 33'
=> true
>> RUBY_VERSION < '1.9' || output.include?('suh-weet')
=> true

>> output = A.new.ri_for(:go, :want_the_description_returned => true).join(' ')
>> output.include? 'a = 33'
=> true
>> RUBY_VERSION < '1.9' || output.include?('suh-weet')
=> true

>> output = A.ri_for(:go2, :want_the_description_returned => true).join(' ')
>> output.include? 'b = 3'
=> true

it should return you something useful
>> A.ri_for(:go2) == nil
=> false
>> A.ri_for(:go) == nil
=> false

it should work with Module
>> FFI::Library.ri_for :attach_function
=end
