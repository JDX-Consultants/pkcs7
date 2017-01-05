require_relative 'sequence'

class ContentInfo < Sequence

    TAG = :U16 # This is a default tag, required for the handling of C0

    DATA_TYPES = {
        'pkcs7-signedData' => 'PKCS7SignedData',
        'pkcs7-data' => 'Node',
        'pkcs7-envelopedData' => 'EnvelopedData',
        'pkcs7-authenticatedData' => 'AuthenticatedData',
    }

    CHILDREN = [Child.new('contentType', 'ContentType')]

    def initialize
        super
        @identifier = nil
    end

    def <<(object)
        object_tag = eval("#{object.class}::TAG")
        @identifier = object if :U6 == object_tag
        super(object)
    end

    def instance_for_tag(tag)
        if tag.to_sym == :C0
            raise "Uninitialised contentType for #{self.class}" unless @identifier
            type = @identifier.value
            class_name = DATA_TYPES[type]
            raise "Invalid code '#{type} in #{self.class}" unless class_name
            Child.new(@identifier.value, class_name).create_child
        else
            super(tag)
        end
    end


end