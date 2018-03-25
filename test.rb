module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type_of_valid, param = nil)
      @validations ||= []
      @validations << { name: name, type_of_valid: type_of_valid, param: param }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        valid_method = "validate_#{validation[:type_of_valid]}".to_sym
        var = instance_variable_get("@#{validation[:name]}")
        param = validation[:param]
        param ? send(valid_method, var, param) : send(valid_method, var)
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(var)
      raise ArgumentError 'Параметр не может быть пустым' if var.nil? || var.empty?
    end

    def validate_format(var, format)
      str = 'Формат имени не соответствует заданному регулярному выражению!'
      raise ArgumentError str unless var =~ format
    end

    def validate_type(var, type)
      str = 'Неправильный тип параметра!'
      if type.class == Class
        raise ArgumentError str unless var.is_a? type
      elsif type.class == Symbol
        raise ArgumentError str unless var == type
      else
        raise ArgumentError str
      end
    end
  end
end
