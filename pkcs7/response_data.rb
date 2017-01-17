class ResponseData < Sequence

    CHILDREN = [
        { name: 'version', class_name: 'IntegerNode', context_specific: 0, optional: true  },
        { name: 'responderID', class_name: 'Name' }, # Should be a choice here
        { name: 'producedAt', class_name: 'DateNode' },
        { name: 'responses', class_name: 'SingleResponses' },
        { name: 'responseExtensions', class_name: 'Extensions', context_specific: 1, optional: true },
    ]

end


# ResponseData ::= SEQUENCE {
#       version              [0] EXPLICIT Version DEFAULT v1,
#       responderID              ResponderID,
#       producedAt               GeneralizedTime,
#       responses                SEQUENCE OF SingleResponse,
#       responseExtensions   [1] EXPLICIT Extensions OPTIONAL }
#  

 # ResponderID ::= CHOICE {
 #      byName               [1] Name,
 #      byKey                [2] KeyHash }
 
 # KeyHash ::= OCTET STRING -- SHA-1 hash of responder's public key
 #   (excluding the tag and length fields)