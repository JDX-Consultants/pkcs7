require_relative 'sequence_of'

# Used for revoked certificates
class CertificateList < SequenceOf

    CHILD = {name: 'signedRevokedCertificate', class_name: 'SignedRevokedCertificates' }

end

# CertificateList ::=
#   SIGNED
#     {SEQUENCE {version              Version OPTIONAL,
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
#                crlExtensions        [0]  Extensions OPTIONAL}}
