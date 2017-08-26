require_relative 'invalid_file_contents'

class BitmapGenerator
  COLOUR_WHITE = 'O'
  attr_reader :source, :image_X, :image_Y

  def initialize(source)
    @source = source
    @image_X = source.first[:x0]
    @image_Y = source.first[:y0]
  end

  def generate
    validate_first_command_creates_image
    image_array = []
    source.each do |instruction|
      image_array = generate_image(instruction, image_array)
    end
    image_array
  end

  private

  def generate_image(command, image_array)
    case command[:command]
      when "I"
        create_image
      when "L"
        change_pixel_colour(command, image_array)
      when "C"
        clear_image
      when "V"
        draw_vertical_line(command, image_array)
      when "H"
        draw_horizontal_line(command, image_array)
      when "S"
        [command[:command], show_image(image_array)]
    end
  end

  def validate_first_command_creates_image
    raise InvalidFileContents if source.first[:command] != "I" || !image_size_within_limits?
  end

  def image_size_within_limits?
    source.first[:x0] >= 1 &&
        source.first[:x0] <= 250 &&
        source.first[:y0] >= 1 &&
        source.first[:y0] <= 250
  end

  def create_image
    Array.new(image_Y) {Array.new(image_X, COLOUR_WHITE)}
  end

  def change_pixel_colour(command, image_array)
    x = command[:x0]
    y = command[:y0]

    raise InvalidFileContents if (x > image_X || y > image_Y)

    image_array[y - 1][x - 1] = command[:colour]
    image_array
  end

  def clear_image
    [[], []]
  end

  def draw_vertical_line(command, image_array)
    x = command[:x0]
    y = command[:y0]
    y1 = command[:y1]

    validate_y(y, y1)

    (y..y1).map do |y_temp|
      image_array[y_temp - 1][x - 1] = command[:colour]
    end
    image_array
  end

  def draw_horizontal_line(command, image_array)
    x = command[:x0]
    x1 = command[:x1]
    y = command[:y0]

    validate_x(x, x1)

    (x..x1).map do |x_temp|
      image_array[y - 1][x_temp - 1] = command[:colour]
    end
    image_array
  end

  def show_image(image_array)
    image_array.map do |rows|
      rows.join("")
    end.join("\n")
  end

  def validate_x(x = 1, x1 = 1)
    raise InvalidFileContents unless x && x1 <= image_X && x < x1
  end

  def validate_y(y = 1, y1 = 1)
    raise InvalidFileContents unless y && y1 <= image_Y && y < y1
  end

end
