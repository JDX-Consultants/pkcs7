require_relative 'typed_sequence'

class Attribute < TypedSequence

    DATA_TYPES = {
        '1.2.840.113583.1.1.8' => 'RevocationInfoArchivals',
        'id-smime-aa-timeStampToken' => 'ContentInfo',        
    }


    CHILDREN = [
        { name: 'type', class_name: 'OIDNode' },
        { name: 'value', class_name: 'AnyNode' },
    ]

end

# Attribute ::= SEQUENCE {
#   type               ATTRIBUTE.&id({SupportedAttributes} },
#   values
#     SET SIZE (0..MAX) OF ATTRIBUTE.&Type({SupportedAttributes}{@type} },
#   valuesWithContext
#     SET SIZE (1..MAX) OF
#       SEQUENCE {value        ATTRIBUTE.&Type({SupportedAttributes}{@type} },
#                 contextList  SET SIZE (1..MAX) OF Context} OPTIONAL
