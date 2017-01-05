class Node

    attr_accessor :name, :value, :tag, :level

    def <<(object)
        @level ||= 0
        object.level = @level+ 1
        # puts "Adding '#{object.class}' to node '#{self.class}', name: #{object.name}"
        puts
        object_tag = object.tag
        printf "#{''.ljust(@level * 2)}#{object.name} (#{object_tag}):"
        raise "Invalid object, expecing a node and received a '#{object.class}' with content #{object.inspect}" unless object.is_a? Node
        @instances ||= [] # Lazy instantiation (and no need for initializer), as some objects are leaves
        @instances << object
    end


    # This class is defined to allow for overwritting
    def tag 
        eval "#{self.class}::TAG"
    end

    def value=(value)
        @value = value.to_s
        printf " #{display_value}"
    end

    def dump(indent)
        dump_name = name ? name.strip : '---'
        if @instances and @instances.size > 0
            puts "#{''.ljust(indent * 2)}#{dump_name.strip}"
            @instances.each { |element| element.dump(indent + 1) }
        else
            puts "#{''.ljust(indent * 2)}#{dump_name}: #{display_value}"
        end
    end

    def display_value()
        return '---' unless @value
        value = @value.strip
        value = value.ascii_only? ? value : value.unpack('H*').first
        value = (value.size > 100 ? "#{value[0..100]}..." : value)
        value
    end

end