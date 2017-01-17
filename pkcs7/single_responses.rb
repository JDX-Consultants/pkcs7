require_relative 'set_of'
require_relative 'child'

class SingleResponses < SequenceOf

    CHILD = { name: 'responses', class_name: 'SingleResponse' }

end

# DigestAlgorithmIdentifiers ::= SET OF DigestAlgorithmIdentifier
