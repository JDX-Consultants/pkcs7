require_relative 'sequence'

class Extension < Sequence

    CHILDREN = [
        { name: 'extnId', class_name: 'OIDNode' },
        { name: 'critical', class_name: 'BooleanNode', optional: true },
        { name: 'value', class_name: 'BinaryNode' },
    ]

    DATA_TYPES = {
        'crlDistributionPoints' => 'DistributionPoints',
        'authorityKeyIdentifier' => 'AuthorityKeyIdentifier',
        'issuerAltName' => 'GeneralNames',
        'subjectAltName' => 'GeneralNames',
        'certificatePolicies' => 'CertificatePolicies',
    }


    def dump(out, indent)
        extension_type = instance_with_tag(:U6)
        extension_value = instance_with_tag(:U4)
        inner_class = DATA_TYPES[extension_type.value]
        if inner_class
            builder = PKCS7Builder.new(inner_class, "EXPANDED from #{inner_class}")
            builder.parse(extension_value.value)
            output = ''
            builder.dump(output, level + 3)
            extension_value.dump_value = output
        end
        super(out, indent)
    end

    def instance_with_tag(tag)
        @instances.each { |instance| return instance if instance.tag == tag}
        raise "Extension: tag #{tag} not found in instances #{@instances}"
    end

end


# Extension ::= SEQUENCE {
#   extnId     EXTENSION.&id({ExtensionSet} },
#   critical   BOOLEAN DEFAULT FALSE,
#   extnValue  OCTET STRING
# } --  contains a DER encoding of a value of type &ExtnType
