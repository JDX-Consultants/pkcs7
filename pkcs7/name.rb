require_relative 'relative_distinguished_names'

class Name < RelativeDistinguishedNames

end


# class Name < Sequence

#     CHILDREN = [
#         { name: 'type', class_name: 'Node' },
#         { name: 'type', class_name: 'Node' },
#     ]

# end


# RelativeDistinguishedName ::=
#   SET SIZE (1..MAX) OF AttributeTypeAndDistinguishedValue
