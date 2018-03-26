
def attr_accessor_with_history(*names)
  names.each do |name|
    define_method(name) { instance_variable_get("@#{name}") }
    define_method("#{name}_history") { instance_variable_get("@#{name}_history") }
    define_method("#{name}=") do |value|
      var_value = instance_variable_get("@#{name}")
      history = instance_variable_get("@#{name}_history") || []
      instance_variable_set("@#{name}_history", history << var_value) unless var_value.nil?
      instance_variable_set("@#{name}", value)
    end
  end
      end
