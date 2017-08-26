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

  it 'returns a list of a hash with keys: command, x, y when command is I' do
    source = 'I 1 1'
    expect(Parser.new(source).parse).to eq([{"command": "I", "x0": 1, "y0": 1}])
  end

  it 'returns a list of a hash with key: command when command is C' do
    source = 'C'
    expect(Parser.new(source).parse).to eq([{"command": "C"}])
  end

  it 'returns a list of a hash with key: command when command is S' do
    source = 'S'
    expect(Parser.new(source).parse).to eq([{"command": "S"}])
  end

  it 'returns a list of a hash with keys: command, x, y, C when command is L' do
    source = 'L 1 1 W'
    expect(Parser.new(source).parse).to eq([{"command": "L", "x0": 1, "y0": 1, colour: "W"}])
  end

  it 'returns a list of a hash with keys: command, x, y1, y2, C when command is V' do
    source = 'V 1 1 1 W'
    expect(Parser.new(source).parse).to eq([{"command": "V", "x0": 1, "y0": 1, "y1": 1, colour: "W"}])
  end

  it 'returns a list of a hash with keys: command, x, y1, y2, C when command is H' do
    source = 'H 1 1 1 W'
    expect(Parser.new(source).parse).to eq([{"command": "H", "x0": 1, "x1": 1, "y0": 1, colour: "W"}])
  end

  it 'returns a list of hashes when mulitline input' do
    source = "H 1 1 1 W\nS\nI 1 1"
    expect(Parser.new(source).parse).to eq([
                                               {"command": "H", "x0": 1, "x1": 1, "y0": 1, colour: "W"},
                                               {"command": "S"},
                                               {"command": "I", "x0": 1, "y0": 1}])
  end

  it 'returns a list of hashes when mulitline input with spaced lines' do
    source = "H 1 1 1 W\n\nS\n\nI 1 1"
    expect(Parser.new(source).parse).to eq([
                                               {"command": "H", "x0": 1, "x1": 1, "y0": 1, colour: "W"},
                                               {"command": "S"},
                                               {"command": "I", "x0": 1, "y0": 1}])
  end

end


