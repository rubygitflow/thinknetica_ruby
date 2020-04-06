# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations
    def validate(name, type, *args)
      @validations ||= []
      @validations << { name: name, type: type, args: args }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate!
      validations = self.class.validations.nil? ? 
                    self.class.superclass.validations : 
                    self.class.validations
      validations.each do |validation|
        validation[:attr] = instance_variable_get("@#{validation[:name]}")
        send validation[:type], validation
      end
    end

    def presence(options)
      raise "Attribute can't be blank!" if options[:attr].to_s.empty?
    end

    def format(options)
      raise 'Wrong format attribute!' if options[:attr] !~ options[:args].first
    end

    def exformat(options)
      return unless options[:attr] !~ options[:args].first ||
                    options[:attr] =~ options[:args].last
      raise 'Wrong format attribute!' 
    end

    def kind(options)
      unless options[:attr].is_a?(options[:args].first)
        raise 'Wrong class of attribute!'
      end
    end
  end
end
