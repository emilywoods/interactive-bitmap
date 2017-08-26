class BitmapEditor

  INVALID_INPUT_MESSAGE = "Error: no file received//nUsage: bin/bitmap_editor example.txt"

  def run(file)
    return STDOUT.puts INVALID_INPUT_MESSAGE if file.nil? || !File.exists?(file)

    file_contents = File.read(file)

    parsed_input, final_command = Parser.new(file_contents).parse
    bitmap = BitmapGenerator.new(parsed_input).generate
    STDOUT.puts(bitmap) if final_command == "S"
  end
end
