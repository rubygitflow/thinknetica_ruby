# frozen_string_literal: true

module Accessors

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attrs)
      attrs.each do |attr|
        raise TypeError, 'attr name is not symbol' unless attr.is_a?(Symbol)

        # define getter
        define_method(attr) { instance_variable_get("@#{attr}") }

        # define setter
        define_method("#{attr}=") do |value|
          @history ||= {}
          @history[attr] ||= []
          @history[attr] << instance_variable_get("@#{attr}")
          instance_variable_set("@#{attr}", value)
        end

        # define method of input history
        define_method("#{attr}_history") { @history[attr] }
      end
    end

    def strong_attr_accessor(name, class_name)
      raise TypeError, 'name is not symbol' unless name.is_a?(Symbol)

      define_method(name) { instance_variable_get("@#{name}") }
      define_method("#{name}=") do |value|
        raise TypeError, 'wrong type of name' unless value.is_a?(class_name)

        instance_variable_set("@#{name}", value)
      end
    end
  end
end
