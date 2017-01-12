require_relative 'sequence'

class CRL < Sequence


    CHILDREN = [
        { name: 'version', class_name: 'Version', context_specific: 0 },
        { name: 'signature', class_name: 'AlgorithmIdentifier' },
        { name: 'issuer', class_name: 'RelativeDistinguishedNames' },
        { name: 'thisUpdate', class_name: 'DateNode' },
        { name: 'nextUpdate', class_name: 'DateNode' },
        { name: 'revokedCertificates', class_name: 'RevokedCertificates' },
        { name: 'crlExtensions', class_name: 'Extensions', context_specific: 3 },
    ]

end

#     SEQUENCE {version              Version OPTIONAL,
#                --  if present, version must be v2
#                signature            AlgorithmIdentifier,
#                issuer               Name,
#                thisUpdate           Time,
#                nextUpdate           Time OPTIONAL,
#                revokedCertificates
#                  SEQUENCE OF
#                    SEQUENCE {userCertificate     CertificateSerialNumber,
#                              revocationDate      Time,
#                              crlEntryExtensions  Extensions OPTIONAL} OPTIONAL,
#                crlExtensions        [0]  Extensions OPTIONAL}

