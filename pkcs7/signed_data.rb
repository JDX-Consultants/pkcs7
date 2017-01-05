require_relative 'sequence'

class SignedData < Sequence

    CHILDREN = [
        Child.new('version', 'Version'),
        Child.new('digestAlgorithms', 'DigestAlgorithmIdentifiers'),
        Child.new('contentInfo', 'ContentInfo'),
        Child.new('certificates', 'CertificateSet', context_specific: 0, optional: true),
        Child.new('crls', 'CertificateRevocationLists', context_specific: 1, optional: true),
        Child.new('signersInfo', 'SignersInfo'),
]

end

# SignedData ::= SEQUENCE {
#   version           Version,
#   digestAlgorithms  DigestAlgorithmIdentifiers,
#   contentInfo       ContentInfo,
#   certificates      [0]  CertificateSet OPTIONAL,
#   crls              [1]  CertificateRevocationLists OPTIONAL,
#   signerInfos       SignerInfos
# }

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