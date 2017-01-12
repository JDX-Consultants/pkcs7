require_relative 'sequence'

class Certificate < Sequence


    CHILDREN = [
        { name: 'version', class_name: 'Version', context_specific: 0 },
        { name: 'serialNumer', class_name: 'CertificateSerialNumber' },
        { name: 'signature', class_name: 'AlgorithmIdentifier' },
        { name: 'issuer', class_name: 'RelativeDistinguishedNames' },
        { name: 'validity', class_name: 'Validity' },
        { name: 'subject', class_name: 'RelativeDistinguishedNames' },
        { name: 'subjectPublicKeyInfo', class_name: 'SubjectPublicKeyInfo' },
        { name: 'issuerUniqueIdentifier', class_name: 'BitStringNode', context_specific:1, implicit: true, optional: true },
        { name: 'subjectUniqueIdentifier', class_name: 'BitStringNode', context_specific:2, implicit: true, optional: true },
        { name: 'extensions', class_name: 'Extensions', context_specific: 3, optional: true },
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
