class SigningCertificate < Sequence

    CHILDREN = [
        { name: 'certs', class_name: 'ESSCertIDs'},
        { name: 'policies', class_name: 'PolicyInformations'},
    ]

end


   # SigningCertificate ::=  SEQUENCE {
   #     certs        SEQUENCE OF ESSCertID,
   #     policies     SEQUENCE OF PolicyInformation OPTIONAL
   # }
