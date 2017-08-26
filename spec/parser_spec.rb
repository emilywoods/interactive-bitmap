require 'rspec'
require 'parser'

describe 'parser' do

  it 'raise error if the contents are not a valid command' do
    expect{Parser.new('Hello').parse}.to raise_error(InvalidFileContents)
  end
end
