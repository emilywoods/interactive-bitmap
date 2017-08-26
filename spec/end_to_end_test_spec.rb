require 'rspec'
require 'tempfile'
require './lib/bitmap_editor'
require './lib/parser'
require 'invalid_file_contents'

describe 'End to end behaviour' do
  let(:test_file) { Tempfile.new('new-file') }

  it 'raises an InvalidFile error when no file is input' do
    stdout = `bin/bitmap_editor `.chomp
    expect(stdout).to eq(BitmapEditor::INVALID_INPUT_MESSAGE)
  end

  it 'raises an InvalidFile error when an invalid file is input' do
    stdout = `bin/bitmap_editor file!%@`.chomp
    expect(stdout).to eq(BitmapEditor::INVALID_INPUT_MESSAGE)
  end

  it 'does not output anything when there is a valid command without Show' do
    create_test_file('I 1 1')
    stdout = `bin/bitmap_editor "#{test_file.path}"`.chomp
    expect(stdout).to eq('')
  end

  it 'shows the correct output when there is a valid command with Show' do
    create_test_file("I 1 1\nS")
    stdout = `bin/bitmap_editor "#{test_file.path}"`.chomp
    expect(stdout).to eq('O')
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
