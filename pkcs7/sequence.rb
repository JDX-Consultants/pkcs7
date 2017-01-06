require_relative 'node'

class Sequence < Node

    TAG = :U16

    def initialize
        @position = 0
        @children = self.class::CHILDREN
        raise "No class defined in #{self.class}" unless @children and @children.size > 0
    end

    def list_exhausted?
        puts "List exhausted" if @position >= @children.size
        @position >= @children.size - 1
    end

    def instance_for_tag(tag)
        (@position..@children.size - 1).each do |i|
            child = @children[i]
            if child.match? tag
                @position = i + 1
                return child.create_child
            else
                raise "\nSequence: mandatory tag '#{tag}' not found in node #{self.class} at position: #{@position}, expecting children #{@children.collect{ |child| child.tag}}" unless child.optional?
            end
        end
        raise "\nSequence: tag '#{tag}' not found in node #{self.class}, position: #{@position}, expecting children #{@children.collect{ |child| child.tag}}"
    end

end