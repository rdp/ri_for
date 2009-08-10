class A
 # a suh-weet rdoc
 def go(a=5)
  a = 33
 end
end
=begin
doctest_require: '../lib/method_desc'
>> output = A.desc_method(:go, :want_the_description_returned => true).join(' ')
>> puts output
>> output.include? 'a = 33'
=> true
>> RUBY_VERSION < '1.9' || output.include?('suh-weet')
=> true

=end
