require 'pp'
require_relative 'sequence'
# Dir[File.join(File.dirname(__FILE__), '*.rb')].each {|file| require file }


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
        if tag.to_sym == :C0
            raise "Uninitialised contentType for #{self.class} at level #{level}" unless @identifier
            type = @identifier.value.to_s
            class_name = self.class::DATA_TYPES[type]
            if class_name
                Child.instantiate({name: @identifier.value, class_name: class_name}).node
            else
                super(tag, level) # For the mment, let's have a default value....
                # raise "Invalid code '#{type} in #{self.class} for level #{level}, identifier is #{type}" unless class_name
            end
        else
            super(tag, level)
        end
    end


end