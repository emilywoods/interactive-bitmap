require 'rspec'
require 'parser'

describe 'parser' do

  it 'raise error if the contents are not a valid command' do
    expect{Parser.new('Hello').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the I command has an incorrect number of arguments' do
    expect{Parser.new('I 1 5 7').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the L command has an incorrect number of arguments' do
    expect{Parser.new('L 5 7').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the V command has an incorrect number of arguments' do
    expect{Parser.new('V 5 7').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the H command has an incorrect number of arguments' do
    expect{Parser.new('H 5 7').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the C command has an incorrect number of arguments' do
    expect{Parser.new('C 5 7').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the S command has an incorrect number of arguments' do
    expect{Parser.new('S 5 7').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the I command has an incorrect type of arguments' do
    expect{Parser.new('I 1 T ').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the L command has an incorrect type of arguments for colour' do
    expect{Parser.new('L 1 1 1').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the L command has an incorrect type of arguments for dimensions' do
    expect{Parser.new('L 1 C 1').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the H command has an incorrect type of arguments for colour' do
    expect{Parser.new('H 1 1 1 1').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the H command has an incorrect type of arguments for dimensions' do
    expect{Parser.new('H 1 M 1 C').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the V command has an incorrect type of arguments for colour' do
    expect{Parser.new('V 1 1 1 1').parse}.to raise_error(InvalidFileContents)
  end

  it 'raises an error if the V command has an incorrect type of arguments for dimensions' do
    expect{Parser.new('V 1 M 1 C').parse}.to raise_error(InvalidFileContents)
  end


  # Two line gap
end


