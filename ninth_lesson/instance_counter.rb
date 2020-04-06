# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances_amount

    def instance_counter
      @instances_amount ||= 0
      @instances_amount += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instance_counter
    end
  end
end
