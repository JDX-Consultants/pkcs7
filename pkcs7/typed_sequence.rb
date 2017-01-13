require 'pp'
require_relative 'sequence'


class TypedSequence < Sequence

    def initialize
        super
        raise "No data_types defined in #{self.class}" unless self.class::DATA_TYPES
    end

    # This method overwrittes the object storing, in order to store the tag
    def <<(object)
        object_tag = eval("#{object.class}.new.node_tag")
        @identifier = object if :U6 == object_tag.to_sym
        super(object)
    end

    def instance_for_tag(tag, level)
        unless tag.to_sym == :U6
            raise "Uninitialised typed sequence for #{self.class} at level #{level}" unless @identifier
            type = @identifier.value.to_s
            class_name = self.class::DATA_TYPES[type]
            if class_name
                child_node = Child.instantiate({name: type, class_name: class_name}).node
            else
                child_node = Child.instantiate({name: 'undefined', class_name: 'AnyNode'}).node # For the time being, let's create an 'any' instead of an exception
                # raise "Invalid code #{type} in #{self.class} for level #{level}, identifier is #{type}" unless class_name
            end
            child_node.level = level
            child_node.tag = tag
            child_node
        else
            super(tag, level)
        end
    end


end