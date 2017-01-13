class ResponseBytes < Sequence


CHILDREN = [
    { name: 'responseType', class_name: 'OIDNode' },
    { name: 'response', class_name: 'BinaryNode' },
]

end

 # ResponseBytes ::=       SEQUENCE {
 #       responseType   OBJECT IDENTIFIER,
 #       response       OCTET STRING }
