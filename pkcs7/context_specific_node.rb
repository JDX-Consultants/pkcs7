Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }

class ContextSpecificNode < Node

    TAG = :U17

    def initialize(child)
        @child = child.clone
        @child.options[:context_specific] = nil
        @name = "#{@child.name} (EXPLICIT)"
    end

    def instance_for_tag(tag)
        node_tag = eval "#{@child.class_name}::TAG"
        raise "Invalid tag for child #{@child.inspect}, received '#{tag}', while expecting '#{node_tag}'" unless node_tag.to_sym == tag.to_sym
        @child.create_child
    end

end