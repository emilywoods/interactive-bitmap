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
        args = validate_num_of_args(line_without_first_char, NUM_ARGS_I)
        convert_list_of_strings_to_int(args)
      when /H/
        args =validate_num_of_args(line_without_first_char, NUM_ARGS_H)
        dimensions = convert_list_of_strings_to_int(args[0..2])
        colour = validate_colour(args[3])
      when /C/
        validate_num_of_args(line_without_first_char, NUM_ARGS_C)
      when /L/
        args = validate_num_of_args(line_without_first_char, NUM_ARGS_L)
        dimensions = convert_list_of_strings_to_int(args[0..1])
        colour = validate_colour(args[2])
      when /V/
        args = validate_num_of_args(line_without_first_char, NUM_ARGS_V)
        dimensions = convert_list_of_strings_to_int(args[0..2])
        colour = validate_colour(args[3])
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

  def convert_list_of_strings_to_int(args)
    args.map do |arg|
      arg.match(/\d+/) ? arg.to_i : (raise InvalidFileContents)
    end
  end

  def validate_colour(colour)
    raise InvalidFileContents unless colour.match(/A-Z/)
  end
end

class InvalidFileContents < StandardError
end
