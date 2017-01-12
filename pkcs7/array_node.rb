require_relative 'node'

class ArrayNode < Node

    def initialize
        raise "Missing CHILD object in #{self.class}" unless self.class::CHILD
        @child = Child.instantiate(self.class::CHILD)

    end

    def instance_for_tag(tag, level)
        if @child.match? tag
            child_node = @child.node
            child_node.level = level
            return child_node
        else
            raise "Invalid tag '#{tag}' received for class #{self.class} at level #{level}, expecting '#{@child.tag}'"
        end
    end

end