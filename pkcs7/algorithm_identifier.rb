require_relative 'sequence'
require_relative 'any_node'
require_relative 'child'


class AlgorithmIdentifier < Sequence

    CHILDREN = [
        Child.new('algorithm', 'OIDNode'),
        Child.new('parameters', 'AnyNode', optional: true),
        Child.new('algorithmParameters', 'Algorithm', optional: true),
        Child.new('undefined', 'AnyNode', optional: true)
    ]

end

# AlgorithmIdentifier ::= SEQUENCE {
#   algorithm   ALGORITHM.&id({SupportedAlgorithms}),
#   parameters  ALGORITHM.&Type({SupportedAlgorithms}{@algorithm}) OPTIONAL
# }

