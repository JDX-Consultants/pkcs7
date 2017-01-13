require_relative 'node'

class AnyNode < Node

    TAG = :ANY

    def instance_for_tag(child, level)
        Child.instantiate({ name: 'any', class_name: 'AnyNode'}).node
    end


end