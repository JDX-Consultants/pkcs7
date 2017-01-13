require_relative 'sequence'

class SignerInfo < Sequence

    CHILDREN = [
        { name: 'version', class_name: 'Version' },
        { name: 'signerIdentifier', class_name: 'SignerIdentifier' },
        { name: 'digestAlgorithms', class_name: 'AlgorithmIdentifier' },
        { name: 'authenticatedAttributes', class_name: 'Attributes', context_specific: 0, implicit: true, optional: true }, # Different from stantard
        { name: 'digestEncryptionAlgorithm', class_name: 'AlgorithmIdentifier' },
        { name: 'encryptedDigest', class_name: 'EncryptedDigest' },
        { name: 'unauthenticatedAttributes', class_name: 'Attributes', context_specific: 1, implicit: true, optional: true }, # Different from stantard
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
