require_relative 'node'

class BinaryNode < Node

    TAG = :U4

    def value=(value)
        @value = value.to_s.strip.unpack('H')
    end
    
end