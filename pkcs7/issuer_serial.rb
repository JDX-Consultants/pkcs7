class IssuerSerial < Sequence

        CHILDREN = [
        { name: 'issuer', class_name: 'GeneralNames' },
        { name: 'serialNumber', class_name: 'CertificateSerialNumber' },
    ]


end


# IssuerSerial ::= SEQUENCE {
#         issuer                   GeneralNames,
#         serialNumber             CertificateSerialNumber
#    }
