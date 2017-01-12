require_relative 'choice_node'

class CertificateChoice < ChoiceNode

    TAG = [Certificate::TAG, :C0, :C1]

    CHOICE = [
        { name: 'certificate', class_name: 'Certificate' },
        { name: 'extendedCertificate', class_name: 'ExtendedCertificate', context_specific: 0 },
        { name: 'attributeCertificate', class_name: 'AttributeCertificate', context_specific: 1 },
    ]

end


# CertificateChoice ::= CHOICE {
#   certificate           Certificate,
#   extendedCertificate   [0]  ExtendedCertificate, -- Obsolete
#   attributeCertificate  [1]  AttributeCertificate
# }
