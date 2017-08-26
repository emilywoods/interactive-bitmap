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
    expect(image).to eq([["C"]])
  end

  it 'should generate a 1d image of rows when the input values are valid' do
    source = [{"command": "I", "x0": 1, "y0": 3}]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["C", "C", "C"]])
  end

  it 'should generate a matrix of cols when the input values are valid' do
    source = [{"command": "I", "x0": 3, "y0": 1}]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["C"], ["C"], ["C"]])
  end

  it 'should generate a matrix of row and cols when the input values are valid' do
    source = [{"command": "I", "x0": 3, "y0": 3}]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["C", "C", "C"], ["C", "C", "C"], ["C", "C", "C"]])
  end

end
