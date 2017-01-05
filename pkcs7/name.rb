require_relative 'relative_distinguished_names'

class Name < RelativeDistinguishedNames

end


# class Name < Sequence

#     CHILDREN = [
#         Child.new('type', 'Node'),
#         Child.new('type', 'Node'),
#     ]

# end


# RelativeDistinguishedName ::=
#   SET SIZE (1..MAX) OF AttributeTypeAndDistinguishedValue
