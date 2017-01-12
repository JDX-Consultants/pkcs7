require_relative 'set_of'

class RelativeDistinguishedName < SetOf

    CHILD = { name: 'name', class_name: 'AttributeTypeAndDistinguishedValue' }

end

# RelativeDistinguishedName ::=
#   SET SIZE (1..MAX) OF AttributeTypeAndDistinguishedValue
