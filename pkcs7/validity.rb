require_relative 'sequence'

class Validity < Sequence

    CHILDREN = [
        { name: 'notBefore', class_name: 'DateNode' },
        { name: 'notAfter', class_name: 'DateNode' },
    ]

end