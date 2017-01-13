# Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }

class Node

    attr_accessor :name, :value, :instances, :level, :tag

    def <<(object)
        Debug.instance.show "\n#{''.ljust(object.level * 4)}#{object.name}_#{object.tag}:"
        raise "Invalid object, expecing a node and received a '#{object.class}' with content #{object.inspect}" unless object.is_a? Node
        @instances ||= [] # Lazy instantiation (and no need for initializer), as some objects are leaves
        @instances << object
    end

    def parse_element(asn_element, level)
        if asn_element.value.is_a?(Array)
            asn_element.value.each do |asn_child_element|
                tag = input_tag(asn_child_element)
                # Debug.instance.show "\n['#{tag}' in '#{self.class}' (L#{level})]"
                new_node = instance_for_tag(tag, level + 1)
                raise "Could not create node in #{self.class} for tag #{tag}" unless new_node
                new_node.level = level
                new_node.tag = tag
                self << new_node
                if new_node.is_a? ImplicitSequence # Horrible trick, if an implicit sequence or choice, pass the whole baby (to avoid 'eating a level')
                    new_node.parse_element asn_element, level + 1
                else
                    new_node.parse_element asn_child_element, level + 1
                end
            end
        else
            @value = asn_element.value.to_s.strip
            Debug.instance.show " #{display_value}"
        end
    end

    def input_tag(asn_node)
        "#{asn_node.tag_class.to_s[0]}#{asn_node.tag}".to_sym
    end

    # This class is defined to allow for overwritting by edge-cases (e.g. context-specific)
    def node_tag
        begin
            eval "#{self.class}::TAG"
        rescue => e
            raise "Tag could not be defined in class #{self.class}: #{e.message}"
        end
    end

    # Should be overwritten by composite nodes (sequence, set, sequence of, set of, implicit sequence, ...) and never invoked for leaf nodes
    def instance_for_tag(tag, level)
        raise "Instance for tag called on leaf node #{self.class} with tag #{tag} and level #{level}"
    end

    def dump(indent)
        dump_name = @name ? @name.gsub('-.', '__') : '---'
        if @instances and @instances.size > 0
            puts "#{''.ljust(indent * 2)}#{dump_name.strip}:"
            @instances.each { |element| element.dump(indent + 1) }
        else
            puts "#{''.ljust(indent * 2)}#{dump_name}: #{display_value}"
        end
    end

    def display_value()
        return '---' unless @value
        value = @value.strip
        value = is_ascii?(value) ? value : value.unpack('H*').first
        value = value.size > 100 ? "#{value[0..100]}...[#{value.size}]" : value
        "'#{value}'"
    end

    def is_ascii?(s)
        s.each_byte { |b| return false if b < 32 or b > 127}
        true
    end

    def to_s
        "#{self.class}: level: #{@level}, name: #{@name}"
    end

end