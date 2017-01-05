Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }

class ContextSpecificNode < Node

    def initialize(child)
        @child = child.clone
        @name = "#{@child.name} (EXPLICIT C#{@child.options[:context_specific]})"
        @child.options[:context_specific] = nil
        # puts "Creating a context_specific node for child #{child}, local node is #{@child}"
    end

    def tag
        @child.tag
    end

    def instance_for_tag(tag)
        node_tag = eval "#{@child.class_name}.new.tag"
        raise "Invalid tag for child #{@child.inspect}, received '#{tag}', while expecting '#{node_tag}'" unless node_tag.to_sym == tag.to_sym
        @child.create_child
    end

end