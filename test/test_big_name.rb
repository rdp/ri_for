class A
 def self.inspect 
    "A(id: integer, b: integer)"
 end
 def go
  33
 end
 def self.go2
   34
 end
end

class B
 def self.go2
    35
 end
end

=begin
doctest: should parse funky inspect classes [railsy], too

doctest_require: '../lib/method_desc'
>> A.desc_method(:go, :want_output => true).join('..')
>> A.desc_method(:go2, :want_output => true).join('..')
>> B.desc_method(:go2, :want_output => true).join('..').include? '35'
=> true
=end 
