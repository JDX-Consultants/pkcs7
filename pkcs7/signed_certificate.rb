require_relative 'implicit_sequence'

class SignedCertificate < ImplicitSequence

    CHILDREN = [
        Child.new('certificate', 'Certificate'),
        Child.new('signatureAlgorithmIdentifier', 'AlgorithmIdentifier'),
        Child.new('signature', 'BitStringNode'),
    ]
end