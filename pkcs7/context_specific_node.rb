Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }

class ContextSpecificNode < Node

    def initialize(child)
        @child = Child.instantiate({class_name: child.class_name, name: child.name})
        @name = child.name
    end

    def instance_for_tag(tag, level)
        new_node = @child.node
        new_node.level = level
        new_node.tag = tag
        new_node
    end

end