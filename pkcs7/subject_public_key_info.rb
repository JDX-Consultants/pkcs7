require_relative 'sequence'

class SubjectPublicKeyInfo < Sequence

    CHILDREN = [
        Child.new('algorithm', 'AlgorithmIdentifier'),
        Child.new('subjectPublicKey', 'BitStringNode')
    ]

end