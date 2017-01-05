require_relative 'sequence'

class IssuerAndSerialNumber < Sequence

    CHILDREN = [
        Child.new('issuer', 'Name'),
        Child.new('serialNumber', 'IntegerNode'),
    ]

end