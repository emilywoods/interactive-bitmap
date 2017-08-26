require 'rspec'
require './lib/bitmap_editor'
require 'tempfile'
require 'parser'
require 'bitmap_generator'

describe 'bitmap_editor' do
  subject(:bitmap_editor) { BitmapEditor.new }
  let(:test_file) { Tempfile.new('new-file') }
  let(:parser) { spy(Parser) }
  let(:bitmap_generator) { spy(BitmapGenerator) }
  let(:file) { spy(File) }

  before(:each) do
    allow(file).to receive(:read).and_return('contents')
    allow(parser).to receive(:new)
    allow(parser).to receive(:parse)
  end

  it 'should output an error message when no file is input' do
    expect(STDOUT).to receive(:puts).with(BitmapEditor::INVALID_INPUT_MESSAGE)
    bitmap_editor.run(nil)
  end

  it 'should output an error message when the file does not exist' do
    expect(STDOUT).to receive(:puts).with(BitmapEditor::INVALID_INPUT_MESSAGE)
    bitmap_editor.run('')
  end

  it 'should output an error message when the file is an invalid format' do
    expect(STDOUT).to receive(:puts).with(BitmapEditor::INVALID_INPUT_MESSAGE)
    bitmap_editor.run('&&')
  end

  it 'should read file contents when the file is a valid format' do
    expect(File).to receive(:read)
    test_file.write('')
    bitmap_editor.run(test_file)
    test_file.unlink
  end

  it 'should parse the file input when the file is valid' do
    expect(Parser).to receive(:new)
    expect(Parser).to receive(:parse)
    test_file.write('')
    bitmap_editor.run(test_file)
    test_file.unlink
  end

  it 'should generate an image when the file is valid' do
    expect(BitmapEditor).to receive(:new)
    expect(BitmapEditor).to receive(:generator)
    test_file.write('')
    bitmap_editor.run(test_file)
    test_file.unlink
  end

  it 'should show the image when the final line is show' do
    expect(STDOUT).to receive(:puts).with('C')
    test_file.write('I 1 1/nS')
    bitmap_editor.run(test_file)
    test_file.unlink
  end
end
