class Parser

  NUM_ARGS_I = 2
  NUM_ARGS_L = 3
  NUM_ARGS_V = 4
  NUM_ARGS_H = 4
  NUM_ARGS_C = 0
  NUM_ARGS_S = 0
  SYM_X0 = :x0
  SYM_Y0 = :y0
  SYM_X1 = :x1
  SYM_Y1 = :y1
  SYM_COMMAND = :command
  SYM_COLOUR = :colour

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
    line_without_first_char = line[1..-1]
    case first_char
      when /I/
        dimensions = validate_num_of_args(line_without_first_char, NUM_ARGS_I)
        dims_as_i = convert_list_of_strings_to_int(dimensions)
        Hash[SYM_COMMAND, first_char, SYM_X0, dims_as_i[0], SYM_Y0, dims_as_i[1]]
      when /H/
        args =validate_num_of_args(line_without_first_char, NUM_ARGS_H)
        dims_as_i = convert_list_of_strings_to_int(args[0..2])
        colour = validate_colour(args[3])
        Hash[SYM_COMMAND, first_char, SYM_X0, dims_as_i[0], SYM_X1, dims_as_i[1], SYM_Y0, dims_as_i[2], SYM_COLOUR, colour]
      when /C|S/
        validate_num_of_args(line_without_first_char, NUM_ARGS_C)
        Hash[SYM_COMMAND, first_char]
      when /L/
        args = validate_num_of_args(line_without_first_char, NUM_ARGS_L)
        dims_as_i = convert_list_of_strings_to_int(args[0..1])
        colour = validate_colour(args[2])
        Hash[SYM_COMMAND, first_char, SYM_X0, dims_as_i[0], SYM_Y0, dims_as_i[1], SYM_COLOUR, colour]
      when /V/
        args = validate_num_of_args(line_without_first_char, NUM_ARGS_V)
        dims_as_i = convert_list_of_strings_to_int(args[0..2])
        colour = validate_colour(args[3])
        Hash[SYM_COMMAND, first_char, SYM_X0, dims_as_i[0], SYM_Y0, dims_as_i[1], SYM_Y1, dims_as_i[2], SYM_COLOUR, colour]
    end
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
    raise InvalidFileContents unless colour.match(/[A-Z]/)
    colour
  end
end

class InvalidFileContents < StandardError
end
