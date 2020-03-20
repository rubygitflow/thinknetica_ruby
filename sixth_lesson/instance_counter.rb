module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :instances_count
    def instance_counter
      @instances_count ||= 0
      @instances_count += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instance_counter
    end
  end
end