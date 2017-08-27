# Bitmap editor

A bitmap is an M x N matrix of pixels with each element representing a colour.

# Prerequisites
This program makes use of ruby gems, such as RSpec and Rubocop (for testing and formatting, respectively).
[Bundler](http://bundler.io/) is used to install and manage these gems.

To install bundler:     
`gem install bundler`

To install the required gems:   
`bundle install`

# Acceptance Criteria
Acceptance Criteria can be found in `ACs.md`

# Input Program
* To run the program, a file (of any extension) must be created, which includes a series of commands for the program to execute.
* The first command specified must create an image (e.g. I 5 5 - create a 5 x 5 image of white pixels)
* The first character of the command is a capital letter, which specifies the type of command to execute.
* Parameters of the command are separated by white spaces and they follow the command character.
* Pixel co-ordinates are a pair of integers: a column number between 1 and 250, and a row number between 1 and 250. Bitmaps starts at coordinates 1,1. Colours are specified by capital letters.

**Allowed commands:**
* I M N - Create a new M x N image with all pixels coloured white (O).
* C - Clears the table, setting all pixels to white (O).
* L X Y C - Colours the pixel (X,Y) with colour C.
* V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
* H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
* S - Show the contents of the current image

# Running
Executing the program:      
`>bin/bitmap_editor examples/show.txt`

Example input: 
```
I 5 6
L 1 3 A
V 2 3 6 W
H 3 5 2 Z
S
```

Expected output:
```
OOOOO
OOZZZ
AWOOO
OWOOO
OWOOO
OWOOO
```

To run the tests:       
`rspec spec/`

To run Rubocop:     
`rubocop`

To run Rubocop with formatting      
`bundle exec rubocop --autocorrect`

# Areas for improvement

 - Separate class for handling user interactions e.g. `UserCommsHelper`     
 The current program relies on receiving input from a user in file format, and outputting as a string to the 
 terminal. However, if in future we would like to take a different approach e.g. receiving input from terminal/GUI,
 or outputting to a file/GUI, we should be able to do so without modifying the BitmapEditor class. This code should be 
 somewhat modular and facilitate easy replacement of the approach to handling user interactions.
 
 

