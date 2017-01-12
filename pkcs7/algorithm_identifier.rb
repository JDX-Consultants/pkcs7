require_relative 'sequence'
require_relative 'any_node'
require_relative 'child'


class AlgorithmIdentifier < Sequence

    CHILDREN = [
        { name: 'algorithm', class_name: 'OIDNode' },
        { name: 'parameters', class_name: 'NullNode', optional: true },
    ]

end

# AlgorithmIdentifier ::= SEQUENCE {
#   algorithm   ALGORITHM.&id({SupportedAlgorithms} },
#   parameters  ALGORITHM.&Type({SupportedAlgorithms}{@algorithm}) OPTIONAL
# }

