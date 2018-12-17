class Tabletop
	attr_reader :dimension

	def initialize(attributes = {})
		#square tabletop
		@dimension = attributes[:dimension] || 5
	end
end