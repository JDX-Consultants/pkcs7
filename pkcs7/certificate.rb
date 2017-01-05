require_relative 'sequence'

class Certificate < Sequence


    CHILDREN = [
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
    ]

end


# Certificate ::=
#   SIGNED
#     {SEQUENCE {version                  [0]  Version DEFAULT v1,
#                serialNumber             CertificateSerialNumber,
#                signature                AlgorithmIdentifier,
#                issuer                   Name,
#                validity                 Validity,
#                subject                  Name,
#                subjectPublicKeyInfo     SubjectPublicKeyInfo,
#                issuerUniqueIdentifier   [1] IMPLICIT UniqueIdentifier OPTIONAL, --  if present, version must be v2 or v3
#                subjectUniqueIdentifier  [2] IMPLICIT UniqueIdentifier OPTIONAL, --  if present, version must be v2 or v3
#                extensions               [3]  Extensions OPTIONAL
#     }} --  If present, version must be v3

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
