require_relative 'node'

class Sequence < Node

    TAG = :U16

    def initialize
        @position = 0
        children = self.class::CHILDREN
        raise "No class defined in #{self.class}" unless children
        @children = children.collect { |child_map| Child.instantiate(child_map)}
    end

    def instance_for_tag(tag, level)
        (@position..@children.size - 1).each do |i|
            child = @children[i]
            if child.match? tag
                @position = i + 1
                child_node = child.node
                child_node.level = level
                return child.node
            else
                raise "Sequence: mandatory tag '#{tag}' not found in node #{self.class} at position: #{@position} and level #{level}, expecting children #{@children.collect{ |child| child.tag}}" unless child.optional?
            end
        end
        raise "Sequence: tag '#{tag}' not found in node #{self.class}, position: #{@position} and level #{level}, expecting children #{@children.collect{ |child| child.tag}}"
    end

end