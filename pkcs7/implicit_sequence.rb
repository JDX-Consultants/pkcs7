require_relative 'node'

# This class is a proxy in front of the children.
# Its purpose is to delegate the actual behaviour to the child class, however remain the 'master' class
# It is used for the 'COMPONENTS OF' in ASN, where there is no real structure, but a
class ImplicitSequence < Node

    def initialize
        @position = 1
        @children = self.class::CHILDREN
        raise "No class defined in #{self.class}" unless @children and @children.size > 0
        @node = @children[0].create_child
        # puts "Sequence initialised with node #{@node}"
    end

    def tag
        @children[@position..-1].collect { |child| child.tag }
    end


    def instance_for_tag(tag)
        if @node
            if @node.list_exhausted?
                puts "\n*** in ImplicitSequence, creating node for child #{@children[@position]}, called with tag #{tag}"
                (@position..- 1).each do |i|
                    child = @children[i]
                    if child.match? tag
                        @position = i + 1
                        # puts "Creating instance for child #{child} and passing tag '#{tag}'"
                        child.create_child.instance_for_tag(tag)
                    else
                        unless child.optional?
                            raise "\nImplicit sequence: tag '#{tag}' not found in node #{self.class}, position: #{@position}, expecting children #{@children.collect{ |child| child.class_name}}"
                        end
                    end
                    raise "\nImplicit sequence: tag '#{tag}' not found in node #{self.class}, position: #{@position}, expecting children #{@children.collect{ |child| child.class_name}}"
                end
            else
                # puts "List not exhausted, calling 'instance_for_tag' on class #{@node.class}"
                @node.instance_for_tag(tag)
            end
        else
            raise "Error in implicit sequence, no node for proxy in class #{self.class}"
        end
    end
end