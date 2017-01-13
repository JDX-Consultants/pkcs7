class OCSPResponses < SequenceOf

    CHILD = { name: 'OCSPResponses', class_name: 'OCSPResponse'}
end


# OCSPResponse ::= SEQUENCE {
#       responseStatus         OCSPResponseStatus,
#       responseBytes          [0] EXPLICIT ResponseBytes OPTIONAL }