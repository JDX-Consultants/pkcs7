require_relative 'choice_node'

class SignerIdentifier < ChoiceNode

    CHOICE = [
        Child.new('issuerAndSerialNumber', 'IssuerAndSerialNumber'),
        Child.new('subjectKeyIdentifier', 'AnyNode', context_specific: 2),
    ]

end


# SignerIdentifier ::= CHOICE {
#   issuerAndSerialNumber  IssuerAndSerialNumber,
#   subjectKeyIdentifier   [2]  SubjectKeyIdentifier
# }
