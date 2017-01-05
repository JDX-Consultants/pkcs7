require_relative 'sequence_of'

class RevokedCertificates< SequenceOf

    CHILD = Child.new 'revokedCertificate', 'RevokedCertificate'

end