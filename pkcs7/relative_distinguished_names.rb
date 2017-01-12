require_relative 'sequence_of'
require_relative 'child'

class RelativeDistinguishedNames < SequenceOf

    CHILD = { name: 'name', class_name: 'RelativeDistinguishedName' }

end

# RDNSequence ::= SEQUENCE OF RelativeDistinguishedName
