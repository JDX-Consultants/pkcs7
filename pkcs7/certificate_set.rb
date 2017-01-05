require_relative 'sequence_of'

class CertificateSet < SequenceOf

    # CHILD = Child.new 'signedCertificate', 'CertificateChoice'
    CHILD = Child.new 'signedCertificate', 'SignedCertificate'

end

# CertificateSet ::= SET OF CertificateChoice