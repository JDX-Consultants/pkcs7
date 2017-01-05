require_relative 'sequence'

class RevokedCertificate < Sequence


    CHILDREN = [
        Child.new('userCertificate', 'CertificateSerialNumber'),
        Child.new('revocationDate', 'DateNode'),
        Child.new('crlExtensions', 'Extensions', context_specific: 3),
    ]

end

#                    SEQUENCE {userCertificate     CertificateSerialNumber,
#                              revocationDate      Time,
#                              crlEntryExtensions  Extensions OPTIONAL} OPTIONAL,

