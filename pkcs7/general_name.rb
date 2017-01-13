class GeneralName < AnyNode

end


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
 

#  OtherName ::= SEQUENCE {
#           type-id    OBJECT IDENTIFIER,
#           value      [0] EXPLICIT ANY DEFINED BY type-id }
 

#  EDIPartyName ::= SEQUENCE {
#           nameAssigner            [0]     DirectoryString OPTIONAL,
#           partyName               [1]     DirectoryString }
 

#  DirectoryString ::= CHOICE {
#     teletexString           TeletexString (SIZE (1..maxSize),
#     printableString         PrintableString (SIZE (1..maxSize)),
#     universalString         UniversalString (SIZE (1..maxSize)),
#     utf8String              UTF8String (SIZE (1.. MAX)),
#     bmpString               BMPString (SIZE(1..maxSIZE))
#  }
 
# When creating a GeneralName object, specify the intended type and the value to be set, e.g.:

#  GeneralName generalName = new GeneralName(
#      GeneralName.uniformResourceIdentifier, "http://www.iaik.tu-graz.ac.at/");
 
# Depending on the type the value has to be an object according to the following assignment:

#   TYPE                              VALUE
#   ====                              =====
#   otherName:                        iaik.asn1.ASN1Object or iaik.asn1.structures.OtherName (if registered)
#   rfc822Name:                       java.lang.String 
#   dNSName:                          java.lang.String
#   x400Address:                      iaik.asn1.ASN1Object
#   directoryName:                    iaik.asn1.structures.Name
#   ediPartyName:                     iaik.asn1.ASN1Object
#   uniformResourceIdentifier:        String
#   iPAddress:                        byte[] array or java.net.InetAddress or String
#   registeredID:                     iaik.asn1.ObjectID
#  