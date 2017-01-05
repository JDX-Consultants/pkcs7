require_relative 'node'

class ArrayNode < Node

    def initialize
        @child = self.class::CHILD
        raise "Missing CHILD object in #{self.class}" unless @child
    end

    def instance_for_tag(tag)
        if @child.match? tag
            @child.create_child
        else
            raise "Invalid tag '#{tag} for class #{self.class}, expecting '#{self.class::TAG}' for name #{self.name}"
        end
    end

end