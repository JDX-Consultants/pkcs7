require_relative 'set_of'
require_relative 'child'

class DigestAlgorithmIdentifiers < SetOf

    CHILD = { name: 'digestAlgorithmIdentifiers', class_name: 'DigestAlgorithmIdentifier' }

end

# DigestAlgorithmIdentifiers ::= SET OF DigestAlgorithmIdentifier
