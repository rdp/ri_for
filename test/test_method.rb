class A
 # a suh-weet rdoc
 def go(a=5)
  a = 33
 end
end
=begin
doctest_require: '../lib/method_desc'
>> output = A.desc_method(:go, :want_output => true).join('..')
>> output.include? 'a = 33'
=> true
>> output.include? 'suh-weet'
=> true

=end
