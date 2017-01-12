require_relative 'sequence'

class SubjectPublicKeyInfo < Sequence

    CHILDREN = [
        { name: 'algorithm', class_name: 'AlgorithmIdentifier' },
        { name: 'subjectPublicKey', class_name: 'BitStringNode' },
    ]

end