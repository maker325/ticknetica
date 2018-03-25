module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, validation, *params)
      @validations ||= []
      @validations << { name: name, validation: validation, params: params }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |hash|
        var_value = instance_variable_get("@#{hash[:name]}")
        send("validate_#{hash[:validation]}", var_value, *hash[:params])
      end
      true
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(var)
      raise 'Параметр не может быть пустым' if var.nil? || var.empty?
    end

    def validate_format(var, format)
      str = 'Формат имени не соответствует заданному регулярному выражению!'
      raise str unless var =~ format
    end

    def validate_type(var, type)
      str = 'Неправильный тип параметра!'
      if type.class == Class
        raise str unless var.is_a? type
      elsif type.class == Symbol
        raise str unless var == type
      else
        raise str
      end
    end
  end
end
