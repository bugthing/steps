class Tool < ActiveRecord::Base

  # get the tool Class object from the string in class_name
  def tool_class
    begin
      class_name.split('::').inject(Object) do |mod, class_name|
        mod.const_get(class_name)
      end
    rescue NameError => e
      # Class for class_name available..
      raise NameError, "Tool class_name (#{class_name}) could be referenced"
    end
  end

end
