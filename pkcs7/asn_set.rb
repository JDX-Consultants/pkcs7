require_relative 'node'
require_relative 'any_node'

class ASNSet < Node

    TAG = :U17

    def initialize
        @children = {}
        children = self.class::CHILDREN
        raise "No class defined in #{self.class}" unless children and children.size > 0
        children.each do |child|
            tag = child.tag
            raise "No TAG defined for node #{child}" unless tag
            @children[tag] = child
        end
    end

    def instance_for_tag(tag)
        raise "No class defined in #{self.class}" unless @children and @children.size > 0
        child = @children[tag]
        if child
            child.create_child
        else
            puts "Set: tag not found: #{tag} in node #{self.class}"
            nil
        end
    end

end