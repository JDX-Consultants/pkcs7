require_relative 'sequence_of'

class SignedRevokedCertificates < SequenceOf

    CHILD = { name: 'revokedCertificate', class_name: 'CRL' }

end