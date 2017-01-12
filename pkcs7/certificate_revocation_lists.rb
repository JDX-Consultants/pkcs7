class CertificateRevocationLists < SetOf

    CHILD = { name: 'certificateList', class_name: 'CertificateList' }

end


# CertificateRevocationLists ::= SET OF CertificateList
