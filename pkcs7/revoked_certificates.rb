require_relative 'sequence_of'

class RevokedCertificates< SequenceOf

    CHILD = { name: 'revokedCertificate', class_name: 'RevokedCertificate' }

end