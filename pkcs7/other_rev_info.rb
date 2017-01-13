require_relative 'sequence'

class OtherRevInfo < Sequence

    # Value of the OID: 1.2.840.113583.1.1.8

    CHILDREN = [
        {name: 'type', class_name: 'OIDNode'},
        {name: 'value', class_name: 'BinaryNode'},
    ]

end

# OtherRevInfo ::= SEQUENCE {
#   Type OBJECT IDENTIFIER
#   Value OCTET STRING
# }
