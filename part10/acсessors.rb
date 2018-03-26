module Aсcessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attributes)
      attributes.each do |attribute|
        var_name = "@#{attribute}".to_sym
        var_history = "@#{attribute}_history".to_sym
        define_method(attribute) { instance_variable_get(var_name) }
        define_method("#{attribute}_history".to_sym) { instance_variable_get(var_history) }
        define_method("#{attribute}=".to_sym) do |value|
          var_value = instance_variable_get(var_name)
          history = instance_variable_get(var_history) || []
          instance_variable_set(var_history, history << var_value) if var_value
          instance_variable_set(var_name, value)
        end
      end
    end

    def strong_attr_accessor(name, class_type)
      var_name = "@#{name}".to_sym
      define_method(name.to_sym) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        raise 'Неправильный тип экземпляра объекта!' unless value.is_a? class_type
        instance_variable_set(var_name, value)
      end
    end
  end
end
