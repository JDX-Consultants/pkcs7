require_relative 'sequence'

class SignedData < Sequence

    CHILDREN = [
        { name: 'version', class_name: 'Version' },
        { name: 'digestAlgorithms', class_name: 'DigestAlgorithmIdentifiers' },
        { name: 'contentInfo', class_name: 'ContentInfo' },
        { name: 'certificates', class_name: 'CertificateSet', context_specific: 0, optional: true },
        { name: 'crls', class_name: 'CertificateRevocationLists', context_specific: 1, optional: true },
        { name: 'signersInfo', class_name: 'SignersInfo' },
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