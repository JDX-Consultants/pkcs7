require_relative 'set_of'

class RevocationInfoArchivals < SetOf

    # Value of the OID: 1.2.840.113583.1.1.8

    CHILD = { name: 'RevocationInfoArchivals', class_name: 'RevocationInfoArchival'}


end

# RevocationInfoArchival ::= SEQUENCE {
#   crl [0] EXPLICIT SEQUENCE of CRLs, OPTIONAL
#   ocsp [1] EXPLICIT SEQUENCE of OCSP Responses, OPTIONAL
#   otherRevInfo [2] EXPLICIT SEQUENCE of OtherRevInfo, OPTIONAL
# }
