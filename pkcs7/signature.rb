require_relative 'sequence'

class Signature < Sequence

    CHILDREN = [
        Child.new('algorithmIdentifier', 'AlgorithmIdentifier'),
        Child.new('encrypted', 'BitString'),
]

end

# ENCRYPTED{ToBeEnciphered} ::=
#   BIT STRING
#     (CONSTRAINED BY {
#        --  must be the result of applying an encipherment procedure 
#        --  to the BER-encoded octets of a value of --ToBeEnciphered})

# SIGNATURE{ToBeSigned} ::= SEQUENCE {
#   algorithmIdentifier  AlgorithmIdentifier,
#   encrypted            ENCRYPTED-HASH{ToBeSigned}
# }

# SIGNED{ToBeSigned} ::= SEQUENCE {
#   toBeSigned  ToBeSigned,
#   COMPONENTS OF SIGNATURE{ToBeSigned}
# }