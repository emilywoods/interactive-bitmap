require 'rspec'
require "tempfile"

require './lib/bitmap_editor'
require 'parser'
require 'bitmap_generator'

RSpec.describe 'bitmap_editor' do
  subject(:bitmap_editor) { BitmapEditor.new }
  let(:test_file) { Tempfile.new("new_file") }
  let(:stdout) {spy(STDOUT)}

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

  it 'should show the image when the final line is S (show)' do
    expect(STDOUT).to receive(:puts).with('O')
    create_test_file("I 1 1\nS")
    bitmap_editor.run(test_file)
  end

  it 'should not show the same when the final line is not S (show)' do
    expect(STDOUT).to_not receive(:puts).with('O')
    create_test_file("I 1 1")
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
