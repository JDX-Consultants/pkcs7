require 'singleton'

class Debug

    include Singleton

    def turn_on
        @display = true
    end

    def turn_off
        @display = false
    end

    def show(s)
        printf s if @display
    end
end
