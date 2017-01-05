require_relative 'sequence'

class Params < Sequence

	def initialize(name)
		super(name)
		add_child('U6', 'Node', 'extnId')
        add_child('U1', 'Node', 'critical')
        add_child('U4', 'Node', 'value')
	end
end