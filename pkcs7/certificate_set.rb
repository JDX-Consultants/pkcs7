require_relative 'set_of'

class CertificateSet < SetOf

    # CHILD = Child.new 'signedCertificate', 'CertificateChoice'
    CHILD = Child.new 'signedCertificate', 'SignedCertificate'

end

# CertificateSet ::= SET OF CertificateChoice