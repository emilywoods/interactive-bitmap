class Parser

  attr_reader :source

  def initialize(source)
    @source = source
  end

  def parse
    command_list = []
    parse_input(@source, command_list)
  end

  private

  def parse_input(source, command_list)
    lines = source.split("\n")
    lines.each do |input_line|
      parsed_line = parse_line(input_line)
      command_list.push(parsed_line)
    end
    command_list
  end

  def parse_line(line)
    first_char = line.slice(0)
    validate_command(first_char)
  end

  def validate_command(char)
    pattern = /(?:H\s)|(?:I\s)|(?:C\s)|(?:L\s)|(?:V\s)|(?:S\s)/
    raise InvalidFileContents unless char.match(pattern)
  end
end

class InvalidFileContents < StandardError
end
