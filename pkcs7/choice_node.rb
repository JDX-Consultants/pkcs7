require_relative 'node'

class ChoiceNode < Node

    # def self.tag
    #     choices = parent::CHOICE
    #     raise "No choice defined for class #{self.class}" unless choices and choices.size > 0
    #     puts "CHOICE for class self.class"
    #     res = choices.collect { |choice| choice.tag }
    #     puts "Tags for choice #{self.class}: #{res}"
    #     res
    # end

    def initialize()
        @choices = {}
        choices = self.class::CHOICE
        raise "Missing CHOICE object in #{self.class}" unless choices
        choices.each do |choice|
            tag = eval "#{choice.class_name}::TAG"
            @choices[tag] = {class_name: choice.class_name, name: choice.name, parameters: choice.options}
        end
    end
    

    def instance_for_tag(tag)
        child = choices[tag]
        if child
            child.create_child
        else
            raise "Invalid tag '#{tag} for class #{self.class}, expecting #{@tag}"
        end
    end

end