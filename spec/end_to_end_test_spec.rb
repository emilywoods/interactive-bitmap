require 'rspec'
require 'tempfile'
require './lib/bitmap_editor'

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

  it 'raises an InvalidInput error when the file has an invalid command' do
    test_file.write('Hey hey')
    run_program = "bin/bitmap_editor '#{test_file.path}'"
    expect { run_program }.to raise_error(InvalidFileError)
    test_file.unlink
  end

  it 'raises an error when the first command is not I' do
    test_file.write('L 1 3 A')
    run_program = "bin/bitmap_editor '#{test_file.path}'"
    expect { run_program }.to raise_error(InvalidFileError)
    test_file.unlink
  end

  it 'raises an error when the image is above the specified limits' do
    test_file.write('I 251 1')
    run_program = "bin/bitmap_editor '#{test_file.path}'"
    expect { run_program }.to raise_error(InvalidFileError)
    test_file.unlink
  end

  it 'raises an error when the image is under the specified limits' do
    test_file.write('I 0 1')
    run_program = "bin/bitmap_editor '#{test_file.path}'"
    expect { run_program }.to raise_error(InvalidFileError)
    test_file.unlink
  end

  it 'raises an error when a command has an invalid number of arguments' do
    test_file.write('I 0 1 1 1')
    run_program = "bin/bitmap_editor '#{test_file.path}'"
    expect { run_program }.to raise_error(InvalidFileError)
    test_file.unlink
  end

  it 'raises an error when a command has an invalid type' do
    test_file.write('I 0 + 1 1')
    run_program = "bin/bitmap_editor '#{test_file.path}'"
    expect { run_program }.to raise_error(InvalidFileError)
    test_file.unlink
  end

  it 'does not output anything when there is a valid command without Show' do
    test_file.write('I 1 1')
    stdout = `bin/bitmap_editor "#{test_file.path}"`.chomp
    expect(stdout).to eq('')
    test_file.unlink
  end

  it 'shows the correct output when there is a valid command with Show' do
    test_file.write("I 1 1\nS")
    stdout = `bin/bitmap_editor "#{test_file.path}"`.chomp
    expect(stdout).to eq('C')
    test_file.unlink
  end
end
