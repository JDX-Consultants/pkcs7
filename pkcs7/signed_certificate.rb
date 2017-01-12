require_relative 'implicit_sequence'

class SignedCertificate < ImplicitSequence

    CHILDREN = [
        { name: 'certificate', class_name: 'Certificate' },
        { name: 'signatureAlgorithmIdentifier', class_name: 'AlgorithmIdentifier' },
        { name: 'signature', class_name: 'BitStringNode' },
    ]
end