require 'sane'
for file in Dir[__dir__ + '/ri_for/*'] do
	 require file
end