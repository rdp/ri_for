# this comment should never be shown
module M
 def go_here
   345
 end
end

class A
 def self.inspect 
    "A(id: integer, b: integer)"
 end
 # this should never be shown with go2
 def go
  33
 end
 # some suh-weet rdoc
 def self.go2
   34
 end
 
 include M
end



class B
 def self.go2
    35
 end
end

=begin
doctest: should parse funky inspect classes [railsy], too

doctest_require: '../lib/ri_for'
>> $VERBOSE = true
>> A.ri_for(:go, :want_the_description_returned => true).join('..')
>> A.ri_for(:go2, :want_the_description_returned => true).join('..')
>> B.ri_for(:go2, :want_the_description_returned => true).join('..').include?('35')
=> true
>> RUBY_VERSION > '1.8' || A.ri_for(:go2, :want_the_description_returned => true).join('..').include?('suh-weet rdoc')
=> true
>> A.ri_for(:go2, :want_the_description_returned => true).join('..').include? 'never be shown'
=> false

# dual whammy... TODO do these test provide full coverage?

>> RUBY_VERSION > '1.8' || A.ri_for(:go_here, :want_the_description_returned => true).join('..').include?('345')
>> RUBY_VERSION > '1.8' || A.ri_for(:go_here, :want_the_description_returned => true).join('..').include?('345')

=end
