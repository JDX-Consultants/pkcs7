class BasicOCSPResponse < Sequence

    CHILDREN = [
        { name: 'tbsResponseData', class_name: 'ResponseData' },
        { name: 'signatureAlgorithm', class_name: 'AlgorithmIdentifier' },
        { name: 'signature', class_name: 'BitStringNode' },
        { name: 'certs', class_name: 'CertificateSet', context_specific: 0 },
    ]

end

 # BasicOCSPResponse       ::= SEQUENCE {
 #      tbsResponseData      ResponseData,
 #      signatureAlgorithm   AlgorithmIdentifier,
 #      signature            BIT STRING,
 #      certs            [0] EXPLICIT SEQUENCE OF Certificate OPTIONAL }
 