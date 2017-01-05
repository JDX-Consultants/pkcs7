require_relative 'set_of'
require_relative 'child'

class DigestAlgorithmIdentifiers < SetOf

    CHILD = Child.new('digestAlgorithmIdentifiers', 'DigestAlgorithmIdentifier')

end

# DigestAlgorithmIdentifiers ::= SET OF DigestAlgorithmIdentifier
