require_relative 'sequence'

class AttributeTypeAndDistinguishedValue < Sequence

    CHILDREN = [
        Child.new('type', 'AnyNode'),
        Child.new('value', 'AnyNode'),
    ]

end

# AttributeTypeAndDistinguishedValue ::= SEQUENCE {
#   type                  ATTRIBUTE.&id({SupportedAttributes}),
#   value                 ATTRIBUTE.&Type({SupportedAttributes}{@type}),
#   primaryDistinguished  BOOLEAN DEFAULT TRUE,
#   valuesWithContext
#     SET SIZE (1..MAX) OF
#       SEQUENCE {distingAttrValue
#                   [0]  ATTRIBUTE.&Type({SupportedAttributes}{@type})
#                     OPTIONAL,
#                 contextList       SET SIZE (1..MAX) OF Context} OPTIONAL

