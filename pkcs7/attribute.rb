require_relative 'sequence'

class Attribute < Sequence

    CHILDREN = [
        Child.new('type', 'Node'),
        Child.new('value', 'AnyNode'),
    ]

end

# Attribute ::= SEQUENCE {
#   type               ATTRIBUTE.&id({SupportedAttributes}),
#   values
#     SET SIZE (0..MAX) OF ATTRIBUTE.&Type({SupportedAttributes}{@type}),
#   valuesWithContext
#     SET SIZE (1..MAX) OF
#       SEQUENCE {value        ATTRIBUTE.&Type({SupportedAttributes}{@type}),
#                 contextList  SET SIZE (1..MAX) OF Context} OPTIONAL
