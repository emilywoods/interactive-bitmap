class Parser

  NUM_ARGS_I = 2
  NUM_ARGS_L = 3
  NUM_ARGS_V = 4
  NUM_ARGS_H = 4
  NUM_ARGS_C = 0
  NUM_ARGS_S = 0

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
    validate_command(line)
    first_char = line.slice(0)
    line_without_first_char = line[1..-1]
    case first_char
      when /I/
        validate_num_of_args(line_without_first_char, NUM_ARGS_I)
      when /H/
        validate_num_of_args(line_without_first_char, NUM_ARGS_H)
      when /C/
        validate_num_of_args(line_without_first_char, NUM_ARGS_C)
      when /L/
        validate_num_of_args(line_without_first_char, NUM_ARGS_L)
      when /V/
        validate_num_of_args(line_without_first_char, NUM_ARGS_V)
      when /S/
        validate_num_of_args(line_without_first_char, NUM_ARGS_S)
    end
  end

  def validate_command(char)
    pattern = /(?:H\s)|(?:I\s)|(?:C\s)|(?:L\s)|(?:V\s)|(?:S\s)/
    raise InvalidFileContents unless char.match(pattern)
  end

  def validate_num_of_args(line, expected_arg_num)
    args = line.split(" ")
    raise InvalidFileContents unless args.size == expected_arg_num
    args
  end
end

class InvalidFileContents < StandardError
end
