require_relative 'sequence'

class SignedCRL < Sequence

    CHILDREN = [
        { name: 'crl', class_name: 'CRL' },
        { name: 'signatureAlgorithmIdentifier', class_name: 'AlgorithmIdentifier' },
        { name: 'signature', class_name: 'BitStringNode' },
    ]
end