require_relative 'node'

class AnyNode < Node

    TAG = :ANY

    def instance_for_tag(child)
        create_child(Child.new('any', 'AnyNode'))
    end


end