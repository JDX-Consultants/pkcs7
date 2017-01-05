require_relative 'sequence'

class Extension < Sequence

    CHILDREN = [
        Child.new('extnId', 'OIDNode'),
        Child.new('critical', 'BooleanNode', optional: true),
        Child.new('value', 'BinaryNode')
    ]

end

# Extension ::= SEQUENCE {
#   extnId     EXTENSION.&id({ExtensionSet}),
#   critical   BOOLEAN DEFAULT FALSE,
#   extnValue  OCTET STRING
# } --  contains a DER encoding of a value of type &ExtnType
