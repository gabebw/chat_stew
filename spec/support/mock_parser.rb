class MockParser
  attr_reader :input

  def initialize
    @did_parse = false
    @input     = nil
  end

  def can_parse?(anything)
    true
  end

  def parse(input)
    @did_parse = true
    @input     = input

    []
  end

  def has_parsed?
    @did_parse == true
  end
end

