require_relative 'sequence_of'

class CertificateSet < SequenceOf

    CHILD = { name: 'signedCertificate', class_name: 'SignedCertificate' }

end

# CertificateSet ::= SET OF CertificateChoice