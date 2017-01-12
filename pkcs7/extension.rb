require_relative 'sequence'

class Extension < Sequence

    CHILDREN = [
        { name: 'extnId', class_name: 'OIDNode' },
        { name: 'critical', class_name: 'BooleanNode', optional: true },
        { name: 'value', class_name: 'BinaryNode' },
    ]

end

# Extension ::= SEQUENCE {
#   extnId     EXTENSION.&id({ExtensionSet} },
#   critical   BOOLEAN DEFAULT FALSE,
#   extnValue  OCTET STRING
# } --  contains a DER encoding of a value of type &ExtnType
