require_relative 'node'

class ChoiceNode < Node

    TAG = :ANY

    def initialize()
        @choices = {}
        choices = self.class::CHOICE
        raise "Missing CHOICE object in #{self.class}" unless choices
        choices.each do |choice|
            tag = eval "#{choice.class_name}.new.tag"
            @choices[tag] = Child.instantiate choice
        end
    end
    

    def instance_for_tag(tag, level)
        child = choices[tag]
        if child
            child.node
        else
            raise "Invalid tag '#{tag} for class #{self.class}, expecting #{@tag}"
        end
    end

end