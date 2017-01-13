require_relative 'sequence'

class RevocationInfoArchival < Sequence

    # Value of the OID: 1.2.840.113583.1.1.8

    CHILDREN = [
        { name: 'crl', class_name: 'CRLs', context_specific: 0, optional: true },
        { name: 'ocsp', class_name: 'OCSPResponses', context_specific: 1, optional: true },
        { name: 'otherRevInfo', class_name: 'OtherRevInfo', context_specific: 2, optional: true },
    ]

end

# RevocationInfoArchival ::= SEQUENCE {
#   crl [0] EXPLICIT SEQUENCE of CRLs, OPTIONAL
#   ocsp [1] EXPLICIT SEQUENCE of OCSP Responses, OPTIONAL
#   otherRevInfo [2] EXPLICIT SEQUENCE of OtherRevInfo, OPTIONAL
# }
