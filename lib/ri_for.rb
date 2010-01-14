require 'sane'
for file in Dir[__dir__ + '/ri_for/*.rb'] do
	 require file
end