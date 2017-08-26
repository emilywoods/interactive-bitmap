## Acceptance Criteria

**Scenario: No input file**\
Given the user does not input a file\
When the user runs the program\
Then an error message is output

**Scenario: File does not exist**\
Given the user inputs a file which does not exist\
When the user runs the program\
Then an error message is output

**Scenario: Valid file, invalid first command**\
Given the user inputs a valid file\
And the first command is not I\
When the user runs the program\
Then an error is raised

**Scenario: Valid file, image outside limits**\
Given the user inputs a valid file\
And the first command is I\
And the image is outside the limits\ 
When the user runs the program\
Then an error is raised

**Scenario: Valid file, unrecognised command**\
Given the user inputs a valid file\
And a command is not recognised\
When the user runs the program\
Then an error is raised

**Scenario: Valid file, command has invalid number of arguments**\
Given the user inputs a valid file\
And the number of arguments of a command is greater than the allowed number\
When the user runs the program\
Then an error is raised

**Scenario: Valid file, command has invalid type of arguments**\
Given the user inputs a valid file\
And the arguments of a command are outside the valid format\
When the user runs the program\
Then an error is raised

**Scenario: Valid file, valid commands, no 'S' command**\
Given the user inputs a valid file\
And the commands are valid
And there is no 'S' command
When the user runs the program\
Then nothing is output

**Scenario: Valid file, valid commands, 'S' command on last line**\
Given the user inputs a valid file\
And the commands are valid\
And there is an 'S' command on the last line\
When the user runs the program\
Then the image is output

**Scenario: Valid file, valid commands, 'S' command not on last line**\
Given the user inputs a valid file\
And the commands are valid\
And there is an 'S' command\
When the user runs the program\
Then the image is output of commands prior to S

**Scenario: Valid file, valid commands, line breaks between each command**\
Given the user inputs a valid file\
And the commands are valid\
And there are spaces between each line\
When the user runs the program\
Then it should correctly parse the file
