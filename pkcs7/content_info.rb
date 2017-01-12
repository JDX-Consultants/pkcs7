require_relative 'sequence'

class ContentInfo < Sequence

    # TAG = :U16 # This is a default tag, required for the handling of C0

    DATA_TYPES = {
        'pkcs7-signedData' => 'PKCS7SignedData',
        'pkcs7-data' => 'BinaryNode',
        'pkcs7-envelopedData' => 'EnvelopedData',
        'pkcs7-authenticatedData' => 'AuthenticatedData',
    }

    CHILDREN = [
        { name: 'contentType', class_name: 'ContentType' },
    ]

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
            class_name = DATA_TYPES[type]
            raise "Invalid code '#{type} in #{self.class} for level #{level}, identifier is #{type}" unless class_name
            Child.instantiate({name: @identifier.value, class_name: class_name}).node
        else
            super(tag, level)
        end
    end


end