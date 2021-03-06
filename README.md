# Toy Robot Simulator

## Table of contents:

* [Setup](./README.md#setup)
* [Running the app](./README.md#running-the-app)
* [Running the tests](./README.md#running-the-tests)
* [Examples of use](./test_data/test_scenarios.txt)
* [Design and Architecture](./README.md#design-and-architecture)
* [Description](./README.md#description)
  * [Constraints](./README.md#constraints)
  * [Example Input and Output](./README.md#example-input-and-output)
  * [Deliverables](./README.md#deliverables)

## Setup

1. Make sure you have Ruby 2.4.4 installed in your machine. If you need help installing Ruby, please refer to the [official installation guide](https://www.ruby-lang.org/en/documentation/installation/).

2. Install the [bundler gem](http://bundler.io/) by running:

    ```gem install bundler```

3. Open the app directory:

    ```cd toy_robot```

4. Install dependencies:

    ```bundle install```

You are now ready to launch the app!

### Running the app:
```ruby lib/app.rb```

### Running the tests:
```rspec spec```

## Design and architecture

A standard MVC pattern was employed in the design of this program with the addition of a router. The responsibilities of each are outlined below:

The program uses two models - the Robot and Table.
* The robot model is responsible for storing, updating and retrieving the position data associated with the robot instance.
* The table model is responsible for storing and validating the constraints of the simulation. For example, the table size and whether a particular command is valid.

The routers role is to dispatch user intent to the right method in the controller.

The controller is responsible for co-ordinating everything needed to complete the user action.

As the user enters through the router in this program, the views responsibility is restricted to displaying information back to the user. For example, the position of the robot and any error messages.

As instructed, a graphical output was not provided. However, error messages were included (even though not specifically required) to improve app usability.

## Description

* The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units.

* There are no other obstructions on the table surface.

* The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

Create an application that can read in commands of the following (textual) form:

    PLACE X,Y,F
    MOVE
    LEFT
    RIGHT
    REPORT

* PLACE will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.

* The origin (0,0) can be considered to be the SOUTH WEST most corner.

* The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.

* MOVE will move the toy robot one unit forward in the direction it is
currently facing.

* LEFT and RIGHT will rotate the robot 90 degrees in the specified direction without changing the position of the robot.

* REPORT will announce the X,Y and F of the robot. This can be in any form, but standard output is sufficient.

* A robot that is not on the table can choose the ignore the MOVE, LEFT, RIGHT and REPORT commands.

* Input can be from a file, or from standard input, as the developer chooses.

* Provide test data to exercise the application.

* The application must be a command line application.

### Constraints

* The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.

* Any move that would cause the robot to fall must be ignored.

### Example Input and Output:

### Example a

    PLACE 0,0,NORTH
    MOVE
    REPORT

Expected output:

    0,1,NORTH

### Example b

    PLACE 0,0,NORTH
    LEFT
    REPORT

Expected output:

    0,0,WEST

### Example c

    PLACE 1,2,EAST
    MOVE
    MOVE
    LEFT
    MOVE
    REPORT

Expected output

    3,3,NORTH

### Deliverables

* Please provide your source code, and any test code/data you using in developing your solution.

* Please engineer your solution to a standard you consider suitable for production. It is not required to provide any graphical output showing the movement of the toy robot.

* Please do not put your name in any of the submitted code since this makes it harder for us to review your submission anonymously.
