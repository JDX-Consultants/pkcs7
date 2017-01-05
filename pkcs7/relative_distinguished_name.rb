require_relative 'set_of'

class RelativeDistinguishedName < SetOf

    CHILD = Child.new('name', 'AttributeTypeAndDistinguishedValue')

end

# RelativeDistinguishedName ::=
#   SET SIZE (1..MAX) OF AttributeTypeAndDistinguishedValue
