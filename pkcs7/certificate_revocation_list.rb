class CertificateRevocationList < SetOf

    CHILD = Child.new('certificateList', 'CertificateList')

end


# CertificateRevocationLists ::= SET OF CertificateList
