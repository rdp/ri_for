require_relative 'method_ri'

class Class
  # just runs ri against the class, outputs a big
  def desc_class options = {}
    # want_output = false, verbose = false
    begin
      puts "begin RI"
      RDoc::RI::Driver.run [to_s, '--no-pager']
      puts 'end ri'
    rescue SystemExit
      # not found
    end

    class_methods = methods(false)
    for ancestor in ancestors[1..-1] # skip the first one, which is yourself
      class_methods -= ancestor.methods(false)
    end

    doc = []
    doc << to_s
    doc += ["non inherited methods:", instance_methods(false).sort.join(", ")]
    doc += ['non inherited class methods:', class_methods.sort.join(', ')]
    doc += ["ancestors:", ancestors.join(', ')] if options[:verbose]
    doc += ["Constants (possible sub classes):",  constants.join(', ')] if constants.length > 0 && options[:verbose]
    puts doc
    doc if options[:want_output]
  end

end

