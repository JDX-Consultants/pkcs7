require_relative 'sequence_of'

class SignedRevokedCertificates < SequenceOf

    CHILD = Child.new 'revokedCertificate', 'CRL'

end