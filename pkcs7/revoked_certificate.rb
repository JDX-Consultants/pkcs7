require_relative 'sequence'

class RevokedCertificate < Sequence


    CHILDREN = [
        { name: 'userCertificate', class_name: 'CertificateSerialNumber' },
        { name: 'revocationDate', class_name: 'DateNode' },
        { name: 'crlExtensions', class_name: 'Extensions', context_specific: 3 },
    ]

end

#                    SEQUENCE {userCertificate     CertificateSerialNumber,
#                              revocationDate      Time,
#                              crlEntryExtensions  Extensions OPTIONAL} OPTIONAL,

