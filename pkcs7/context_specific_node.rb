Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }

class ContextSpecificNode < Node

    def initialize(child)
        @child = Child.instantiate({class_name: child.class_name, name: child.name})
        @name = "#{@child.name} (EXPLICIT)"
    end

    def instance_for_tag(tag, level)
        @child.node.level = level
        @child.node
    end

end