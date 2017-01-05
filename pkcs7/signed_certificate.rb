require_relative 'sequence'

class SignedCertificate < Sequence

    CHILDREN = [
        # Child.new('certificate', 'Certificate'),
        Child.new('version', 'Version', context_specific: 0),
        Child.new('serialNumer', 'CertificateSerialNumber'),
        Child.new('signature', 'AlgorithmIdentifier'),
        Child.new('issuer', 'RelativeDistinguishedNames'),
        Child.new('validity', 'Validity'),
        Child.new('subject', 'RelativeDistinguishedNames'),
        Child.new('subjectPublicKeyInfo', 'SubjectPublicKeyInfo'),
        Child.new('issuerUniqueIdentifier', 'BitStringNode', context_specific:1, implicit: true, optional: true),
        Child.new('subjectUniqueIdentifier', 'BitStringNode', context_specific:2, implicit: true, optional: true),
        Child.new('extensions', 'Extensions', context_specific: 3, optional: true),
        Child.new('algorithm', 'OIDNode'),
        Child.new('parameters', 'AnyNode', optional: true),
        # Child.new('signatureAlgorithmIdentifier', 'AlgorithmIdentifier'),
        Child.new('signature', 'BitStringNode'),
    ]
end