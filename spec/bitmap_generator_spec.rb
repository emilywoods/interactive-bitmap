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
    expect(image).to eq([["O"], ["O"], ["O"]])
  end

  it 'should generate a matrix of cols when the input values are valid' do
    source = [{"command": "I", "x0": 3, "y0": 1}]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O", "O", "O"]])
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

  it 'should raise an error if L(x0) is greater than I(x0)' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "L", "x0": 7, "y0": 1, "colour": "C"} ]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should raise an error if L(y0) is greater than I(y0)' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "L", "x0": 2, "y0": 6, "colour": "C"} ]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should clear an image, by setting all pixels to white ' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "L", "x0": 2, "y0": 2, "colour": "C"}, {"command": "C"} ]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O", "O", "O"], ["O", "O", "O"], ["O", "O", "O"]])
  end

  it 'should draw a vertical segment - V 3 1 2 G' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "V", "x0": 3, "y0": 1, "y1": 2, "colour": "G" } ]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O", "O", "G"], ["O", "O", "G"], ["O", "O", "O"]])
  end

  it 'should raise an error if the V(y1) value is less than V(y0)' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "V", "x0": 3, "y0": 5, "y1": 1, "colour": "G" } ]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should raise an error if the V(y0) value is greater than I(y0)' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "V", "x0": 3, "y0": 1, "y1": 5, "colour": "G" } ]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should raise an error if the V(x0) value is greater than I(x0)' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "V", "x0": 5, "y0": 1, "y1": 5, "colour": "G"  } ]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should draw a horizontal segment H 1 3 2 G' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "H", "x0": 1, "x1": 3, "y0": 2, "colour": "G" } ]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq([["O", "O", "O"], ["G", "G", "G"], ["O", "O", "O"]])
  end

  it 'should raise an error if the H(x1) value is less than H(x0)' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "H", "x0": 2, "x1": 1, "y0": 2, "colour": "G" } ]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should raise an error if the H(x1) value is greater than I(x0)' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "H", "x0": 5, "x1": 4, "y0": 2, "colour": "G" } ]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should raise an error if the H(y0) value is greater than I(y0)' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "H", "x0": 1, "x1": 1, "y0": 5, "colour": "G" } ]
    expect{BitmapGenerator.new(source).generate}.to raise_error(InvalidFileContents)
  end

  it 'should show the image' do
    source = [{"command": "I", "x0": 3, "y0": 3}, {"command": "S"} ]
    image = BitmapGenerator.new(source).generate
    expect(image).to eq(["S", "OOO\nOOO\nOOO"])
  end
end
