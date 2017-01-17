class AuthorityKeyIdentifier < Sequence

    CHILDREN = [
        { name: 'keyIdentifier', class_name: 'BinaryNode', context_specific: 0 },
        { name: 'authorityCertIssuer', class_name: 'GeneralNames', context_specific: 1 },
        { name: 'authorityCertSerialNumber', class_name: 'IntegerNode', context_specific: 2 },
    ]

end


#  AuthorityKeyIdentifier ::= SEQUENCE {
#    keyIdentifier             [0] KeyIdentifier           OPTIONAL,
#    authorityCertIssuer       [1] GeneralNames            OPTIONAL,
#    authorityCertSerialNumber [2] CertificateSerialNumber OPTIONAL    }

# where:

#  KeyIdentifier ::= OCTET STRING


#  GeneralNames ::= SEQUENCE SIZE (1..MAX) OF GeneralName


#  GeneralName ::= CHOICE {
#           otherName                       [0]     OtherName,
#           rfc822Name                      [1]     IA5String,
#           dNSName                         [2]     IA5String,
#           x400Address                     [3]     ORAddress,
#           directoryName                   [4]     Name,
#           ediPartyName                    [5]     EDIPartyName,
#           uniformResourceIdentifier       [6]     IA5String,
#           iPAddress                       [7]     OCTET STRING,
#           registeredID                    [8]     OBJECT IDENTIFIER}


#  CertificateSerialNumber  ::=  INTEGER