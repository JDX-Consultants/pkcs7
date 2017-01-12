require_relative 'node'
require 'pp'

# This class is a proxy in front of the children.
# Its purpose is to delegate the actual behaviour to the child class, however remain the 'master' class
# It is used for the 'COMPONENTS OF' in ASN, where there is no real structure, but needs high-level to be 'absorbed'
class ImplicitSequence < Sequence

    def initialize
        # puts "\nImplicit sequence initialized, children= #{self.class::CHILDREN} by #{caller.first}"
        @position = 0
        raise "No class defined in #{self.class}" unless self.class::CHILDREN
        @children = self.class::CHILDREN.collect { |child_map| Child.instantiate(child_map)}
    end

    def node_tag
        @children[@position..-1].collect { |child| child.tag }
    end

    def to_s
        "#{self.class}, name: #{@name}, position: #{@position}"
    end
end