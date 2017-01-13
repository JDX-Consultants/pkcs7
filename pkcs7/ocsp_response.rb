class OCSPResponse < Sequence

    CHILDREN = [
        { name: 'responseStatus', class_name: 'OCSPResponseStatus' },
        { name: 'responseBytes', class_name: 'ResponseBytes', context_specific: 0, optional: true },
    ]

end


# OCSPResponse ::= SEQUENCE {
#       responseStatus         OCSPResponseStatus,
#       responseBytes          [0] EXPLICIT ResponseBytes OPTIONAL }