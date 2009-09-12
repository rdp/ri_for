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
doctest_require: '../lib/desc_method'
>> $VERBOSE = true
>> output = A.desc_method(:go, :want_the_description_returned => true).join(' ')
>> output.include? 'a = 33'
=> true
>> RUBY_VERSION < '1.9' || output.include?('suh-weet')
=> true

>> output = A.new.desc_method(:go, :want_the_description_returned => true).join(' ')
>> output.include? 'a = 33'
=> true
>> RUBY_VERSION < '1.9' || output.include?('suh-weet')
=> true

>> output = A.desc_method(:go2, :want_the_description_returned => true).join(' ')
>> output.include? 'b = 3'
=> true

it should return you something useful
>> A.desc_method(:go2) == nil
=> false
>> A.desc_method(:go) == nil
=> false
=end
