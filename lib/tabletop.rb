class Tabletop
	attr_reader :dimension

	def initialize(attributes = {})
		@dimension = attributes[:dimension] || 5
		#square tabletop
	end
end