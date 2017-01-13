class ESSCertID < Sequence

    CHILDREN = [
        {name: 'certHash', class_name: 'HashNode'},
        {name: 'issuerSerial', class_name: 'IssuerSerial', optional: true},
    ]

end

    # ESSCertID ::=  SEQUENCE {
    #         certHash                 Hash,
    #         issuerSerial             IssuerSerial OPTIONAL
    #    }