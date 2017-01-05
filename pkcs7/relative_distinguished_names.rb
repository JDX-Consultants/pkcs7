require_relative 'sequence_of'
require_relative 'child'

class RelativeDistinguishedNames < SequenceOf

    CHILD = Child.new('name', 'RelativeDistinguishedName')

end

# RDNSequence ::= SEQUENCE OF RelativeDistinguishedName
