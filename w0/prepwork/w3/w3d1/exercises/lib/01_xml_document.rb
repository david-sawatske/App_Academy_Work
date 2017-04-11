class XmlDocument
   def initialize indent = false
      @indent = indent
      @indent_depth = 0
   end

   def method_missing name, *args, &block
      attributes = args[0] || {}
      xml = ""
      xml << "  " * @indent_depth if @indent
      xml << "<#{name}"

      attributes.each do |key, value|
         xml << " #{key}=\"#{value}\""
      end

      if block
         xml << ( @indent ? ">\n" : ">" )
         @indent_depth += 1

         xml << yield
         @indent_depth -= 1

         xml << "  " * @indent_depth if @indent

         xml << ( @indent ? "</#{name}>\n" : "</#{name}>" )
      else
         xml << ( @indent ? "/>\n" : "/>" )
      end

      xml
   end
end
