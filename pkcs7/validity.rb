require_relative 'sequence'

class Validity < Sequence

    CHILDREN = [
        Child.new('notBefore', 'DateNode'),
        Child.new('notAfter', 'DateNode'),
    ]

end