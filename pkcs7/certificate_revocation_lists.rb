require_relative 'set_of'

class CertificateRevocationLists < SetOf

    CHILD = { name: 'certificateList', class_name: 'CertificateList' }

end


# CertificateRevocationLists ::= SET OF CertificateList
