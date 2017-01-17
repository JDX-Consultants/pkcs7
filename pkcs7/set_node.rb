require_relative 'node'
require_relative 'any_node'

class SetNode < Node

    TAG = :U17

    def initialize
        raise "No class defined in #{self.class}" unless self.class::CHILDREN
        children = self.class::CHILDREN.collect { |child| Child.instantiate(child)}
        # TODO: could be improved in a single line I guess...  Ruby explaration
        @children = {}
        children.each do |child|
            tag child.tag
            raise "No TAG defined for node #{child}" unless tag
            @children[tag] = child
        end
    end

    def instance_for_tag(tag, level)
        child = @children[tag]
        if child
            child_node =  child.node
            child_node.level = level
            child_node.tag tag
            child_node
        else
            raise "Invalid tag received for node #{self.class}, received #{tag} at #{level}, while expecting #{@children}"
        end
    end

end