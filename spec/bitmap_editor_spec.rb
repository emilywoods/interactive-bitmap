require 'rspec'
require './lib/bitmap_editor'
require 'tempfile'

describe 'bitmap_editor' do
  subject(:bitmap_editor) {BitmapEditor.new}
  let(:test_file) { Tempfile.new("new-file") }

  it 'should output an error message when no file is input' do
    expect(STDOUT).to receive(:puts).with(BitmapEditor::INVALID_INPUT_MESSAGE)
    bitmap_editor.run(nil)
  end

  it 'should output an error message when the file does not exist' do
    expect(STDOUT).to receive(:puts).with(BitmapEditor::INVALID_INPUT_MESSAGE)
    bitmap_editor.run("")
  end

  it 'should output an error message when the file is an invalid format' do
    expect(STDOUT).to receive(:puts).with(BitmapEditor::INVALID_INPUT_MESSAGE)
    bitmap_editor.run("&&")
  end

  it 'should parse the file input when the file is valid' do
    bitmap_editor.run(test_file)
    expect(Parser).to have_received(:new)
    test_file.unlink
  end

  it 'should generate an image when the file is valid' do
    bitmap_editor.run(test_file)
    expect(BitmapGenerator).to have_received(:new)
    test_file.unlink
  end

  it 'should show the image when the final line is show' do
    test_file.write("I 1 1/nS")
    bitmap_editor.run(test_file)
    expect(STDOUT).to receive(:puts).with('C')
    test_file.unlink
  end
end
