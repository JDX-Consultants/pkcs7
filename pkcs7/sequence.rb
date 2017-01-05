require_relative 'node'

class Sequence < Node

    TAG = :U16

    def initialize
        @position = 0
        @children = self.class::CHILDREN
        raise "No class defined in #{self.class}" unless @children and @children.size > 0
    end

    def instance_for_tag(tag)
        (@position..(@children.size - 1)).each do |i|
            child = @children[i]
            if child.match? tag
                @position = i + 1
                return child.create_child
            else
                unless child.optional?
                    raise "\nSequence: tag '#{tag}' not found in node #{self.class}, position: #{@position}, expecting children #{@children.collect{ |child| child.class_name}}"
                # else
                #     puts "\n... skipping tag #{child.tag} when looking for #{tag}"
                end
            end
        end
        raise "\nSequence: tag '#{tag}' not found in node #{self.class}, position: #{@position}, expecting children #{@children.collect{ |child| child.class_name}}"
    end

end