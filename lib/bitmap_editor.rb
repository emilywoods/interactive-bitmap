require_relative 'parser'
require_relative 'bitmap_generator'

class BitmapEditor
  INVALID_INPUT_MESSAGE = 'Error: no file received/
/nUsage: bin/bitmap_editor example.txt'.freeze

  def run(file)
    return STDOUT.puts INVALID_INPUT_MESSAGE if file.nil? || !File.exist?(file)

    file_contents = File.read(file)

    parsed_input = Parser.new(file_contents).parse
    bitmap = BitmapGenerator.new(parsed_input).generate
    STDOUT.puts(bitmap[1]) if bitmap[0] == 'S'
  end
end
