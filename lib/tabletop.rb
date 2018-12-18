class Tabletop
  attr_reader :dimension

  def initialize(attributes = {})
    # Tabletop is square.
    # Tabletop size: dimension x dimension
    @dimension = attributes[:dimension]
  end
end