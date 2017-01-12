require_relative 'sequence'

class Params < Sequence

#TODO

CHILDREN = [
        {name: 'extnId', class_name: 'OIDNode'},
        {name: 'critical', class_name: 'BooleanNode'},
        {name: 'value', class_name: 'BinaryNode'},
]
end