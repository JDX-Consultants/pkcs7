require_relative 'choice_node'

class CertificateChoice < ChoiceNode

    TAG = [Certificate::TAG, :C0, :C1]

    CHOICE = [
        Child.new('certificate', 'Certificate'),
        Child.new('extendedCertificate', 'ExtendedCertificate', context_specific: 0),
        Child.new('attributeCertificate', 'AttributeCertificate', context_specific: 1),
    ]

end


# CertificateChoice ::= CHOICE {
#   certificate           Certificate,
#   extendedCertificate   [0]  ExtendedCertificate, -- Obsolete
#   attributeCertificate  [1]  AttributeCertificate
# }
