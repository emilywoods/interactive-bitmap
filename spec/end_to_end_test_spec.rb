require 'rspec'
require 'tempfile'

describe 'End to end behaviour' do
  let(:test_file) { Tempfile.new("new-file") }

  it 'raises an InvalidFile error when no file is input' do
    expect {'bin/bitmap_editor '}.to raise_error(InvalidFileError)
  end

  it 'raises an InvalidFile error when an invalid file is input' do
    expect {'bin/bitmap_editor file!%@.txt'}.to raise_error(InvalidFileError)
  end

  it 'raises an InvalidInput error when the file has an invalid command' do
    test_file.write('Hey hey')
    expect {"ruby lib/emerald.rb '#{test_file.path}'"}.to raise_error(InvalidFileError)
    test_file.unlink
  end

end
