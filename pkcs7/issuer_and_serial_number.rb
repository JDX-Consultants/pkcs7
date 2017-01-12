require_relative 'sequence'

class IssuerAndSerialNumber < Sequence

    CHILDREN = [
        { name: 'issuer', class_name: 'Name' },
        { name: 'serialNumber', class_name: 'IntegerNode' },
    ]

end