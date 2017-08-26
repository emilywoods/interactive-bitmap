require 'invalid_file_contents'

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
    image_array.first
  end

  private

  def generate_image(instruction, image_array)
    case instruction[:command]
      when "I"
        create_image(image_array)
      when "L"
        change_pixel_colour(instruction, image_array)
    end
  end


  def validate_first_command_creates_image
    raise InvalidFileContents if source.first[:command] != "I" || !image_size_within_limits?
  end

  def image_size_within_limits?
    source.first[:x0] >= 1 &&
        source.first[:x0] < 250 &&
        source.first[:y0] >= 1 &&
        source.first[:y0] < 250
  end

  def create_image(image_array)
    image_array.push(Array.new(image_X) { Array.new(image_Y, COLOUR_WHITE) })
  end

  def change_pixel_colour(instruction, image_array)
    x = instruction[:x0]
    y = instruction[:y0]
    image_array.first[y - 1][ x - 1 ] = instruction[:colour]
    image_array
  end
end
