require_relative 'sequence'

class CRL < Sequence


    CHILDREN = [
        Child.new('version', 'Version', context_specific: 0),
        Child.new('signature', 'AlgorithmIdentifier'),
        Child.new('issuer', 'RelativeDistinguishedNames'),
        Child.new('thisUpdate', 'DateNode'),
        Child.new('nextUpdate', 'DateNode'),
        Child.new('revokedCertificates', 'RevokedCertificates'),
        Child.new('crlExtensions', 'Extensions', context_specific: 3),
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

