require_relative 'sequence'

class SignerInfo < Sequence

    CHILDREN = [
        Child.new('version', 'Version'),
        Child.new('signerIdentifier', 'SignerIdentifier'),
        Child.new('digestAlgorithms', 'AlgorithmIdentifier'),
        Child.new('authenticatedAttributes', 'Attributes', context_specific: 0),
        Child.new('digestEncryptionAlgorithm', 'AlgorithmIdentifier'),
        Child.new('encryptedDigest', 'EncryptedDigest'),
        Child.new('unauthenticatedAttributes', 'Attributes', context_specific: 1),
    ]

end

# SignerInfo ::= SEQUENCE {
#   version                    Version,
#   signerIdentifier           SignerIdentifier,
#   digestAlgorithm            DigestAlgorithmIdentifier,
#   authenticatedAttributes    [0]  Attributes OPTIONAL,
#   digestEncryptionAlgorithm  DigestEncryptionAlgorithmIdentifier,
#   encryptedDigest            EncryptedDigest,
#   unauthenticatedAttributes  [1]  Attributes OPTIONAL
# }
