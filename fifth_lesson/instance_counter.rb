module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      self.instances_count
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.instances_count += 1
    end
  end

  protected
  attr_accessor :instances_count

end
