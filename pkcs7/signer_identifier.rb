require_relative 'choice_node'


# Temp fix before checking the choice node (if needed)
class SignerIdentifier < IssuerAndSerialNumber

end


# class SignerIdentifier < ChoiceNode

#     CHOICE = [
#         { name: 'issuerAndSerialNumber', class_name: 'IssuerAndSerialNumber' },
#         { name: 'subjectKeyIdentifier', class_name: 'AnyNode', context_specific: 2 },
#     ]

# end


# SignerIdentifier ::= CHOICE {
#   issuerAndSerialNumber  IssuerAndSerialNumber,
#   subjectKeyIdentifier   [2]  SubjectKeyIdentifier
# }
