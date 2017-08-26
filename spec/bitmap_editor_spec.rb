require 'rspec'
require 'tempfile'

require './lib/bitmap_editor'

RSpec.describe 'bitmap_editor' do
  subject(:bitmap_editor) { BitmapEditor.new }
  let(:test_file) { Tempfile.new('new_file') }
  let(:stdout) { spy(STDOUT) }

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

  it 'raises an InvalidInput error when the file has an invalid command' do
    create_test_file('Hey hey')
    expect { bitmap_editor.run(test_file) }.to raise_error(InvalidFileContents)
  end

  it 'raises an error when the first command is not I' do
    create_test_file('L 1 3 A')
    expect { bitmap_editor.run(test_file) }.to raise_error(InvalidFileContents)
  end

  it 'raises an error when the image is above the specified limits' do
    create_test_file('I 251 1')
    expect { bitmap_editor.run(test_file) }.to raise_error(InvalidFileContents)
  end

  it 'raises an error when the image is under the specified limits' do
    create_test_file('I 0 1')
    expect { bitmap_editor.run(test_file) }.to raise_error(InvalidFileContents)
  end

  it 'raises an error when a command has an invalid number of arguments' do
    create_test_file('I 0 1 1 1')
    expect { bitmap_editor.run(test_file) }.to raise_error(InvalidFileContents)
  end

  it 'raises an error when a command has an invalid type' do
    create_test_file('I 0 +')
    expect { bitmap_editor.run(test_file) }.to raise_error(InvalidFileContents)
  end

  it 'should show the image when the final line is S (show)' do
    expect(STDOUT).to receive(:puts).with('O')
    create_test_file("I 1 1\nS")
    bitmap_editor.run(test_file)
  end

  it 'should not show the same when the final line is not S (show)' do
    expect(STDOUT).to_not receive(:puts).with('O')
    create_test_file('I 1 1')
    bitmap_editor.run(test_file)
  end

  it 'should show the image when the final line is S (show)' do
    expect(STDOUT).to receive(:puts).with('OOOOO
OOZZZ
AWOOO
OWOOO
OWOOO
OWOOO')
    create_test_file("I 5 6
L 1 3 A
V 2 3 6 W
H 3 5 2 Z
S")
    bitmap_editor.run(test_file)
  end

  def create_test_file(contents)
    test_file.write(contents)
    test_file.rewind
  end

  after(:each) do
    test_file.close
    test_file.unlink
  end
end
