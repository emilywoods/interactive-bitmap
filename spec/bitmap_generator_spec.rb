require 'rspec'
require './lib/bitmap_generator'
require 'invalid_file_contents'

describe 'bitmap_generator' do

  it 'should raise an error if the first command is not I' do
    source = [{"command": "S"}]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should raise an error if the image x value is greater than 250' do
    source = [{"command": "I", "x0": 251, "y0": 1}]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should raise an error if the image x value is less than 1' do
    source = [{"command": "I", "x0": 0, "y0": 1}]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should raise an error if the image y value is greater than 250' do
    source = [{"command": "I", "x0": 250, "y0": 251}]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should raise an error if the image y value is less than 1' do
    source = [{"command": "I", "x0": 1, "y0": 0}]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should generate a pixel image when the input values are valid' do
    source = [{"command": "I", "x0": 1, "y0": 1}]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O"]])
  end

  it 'should generate a 1d image of rows when the input values are valid' do
    source = [{"command": "I", "x0": 1, "y0": 3}]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O", "O", "O"]])
  end

  it 'should generate a matrix of cols when the input values are valid' do
    source = [{"command": "I", "x0": 3, "y0": 1}]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O"], ["O"], ["O"]])
  end

  it 'should generate a matrix of row and cols when the input values are valid' do
    source = [{"command": "I", "x0": 3, "y0": 3}]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O", "O", "O"], ["O", "O", "O"], ["O", "O", "O"]])
  end

  it 'should change the colour of a pixel in a 2x2 image' do
    source = [{"command": "I", "x0": 2, "y0": 2}, {"command": "L", "x0": 1, "y0": 2, "colour": "C"} ]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O", "O"], ["C", "O"]])
  end

  it 'should change the colour of a pixel in a 3x3 imag' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "L", "x0": 2, "y0": 1, "colour": "C"} ]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O", "C", "O"], ["O", "O", "O"], ["O", "O", "O"]])
  end

  it 'should clear an image' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "C"} ]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([[],[]])
  end

  it 'should draw a vertical segment V 2 3 6 W' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "V", "x0": 3, "y0": 1, "y1": 2, "colour": "G" } ]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O", "O", "G"], ["O", "O", "G"], ["O", "O", "O"]])
  end
end
