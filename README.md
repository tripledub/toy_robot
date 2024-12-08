# Toy Robot Simulator

The Toy Robot Simulator is a command-line application that simulates a toy robot moving on a 5x5 tabletop grid. The robot can be placed, moved, rotated, and asked to report its position, all while respecting the table's boundaries.

## Features

- **Place the Robot** at a specific position and orientation on the tabletop.
- **Move the Robot** one unit forward in the direction it is facing.
- **Turn the Robot** left or right (90 degrees).
- **Report the Position** of the robot.
- **File-Based Commands:** Execute a series of pre-defined commands from a file.
- **Interactive REPL:** Control the robot interactively via a command-line interface.

## Usage

The simulator can be used in two modes: **File Mode** and **Interactive REPL Mode**.

### File Mode

Run commands from a file by specifying the file path:

```bash
./toy_robot_simulator.rb --file commands.txt
```

**Command File Format**

The command file should contain one command per line, such as:

```plantext
PLACE 0,0,NORTH
MOVE
LEFT
REPORT
```

**REPL Mode**

Start an interactive session to control the robot manually:

```
ToyRobot REPL started. Type commands or 'EXIT' to quit.
> PLACE 0,0,NORTH
> MOVE
> REPORT
Robot is at (0, 1) facing NORTH
> EXIT
```

| Command       | Description                                                                 |
| ------------- | --------------------------------------------------------------------------- |
| `PLACE X,Y,F` | Places the robot at position `(X, Y)` facing direction `F` (`NORTH`, etc.). |
| `MOVE`        | Moves the robot one unit forward in the current direction.                  |
| `LEFT`        | Rotates the robot 90 degrees to the left.                                   |
| `RIGHT`       | Rotates the robot 90 degrees to the right.                                  |
| `REPORT`      | Prints the robot's current position and facing direction.                   |

**Example**

```
PLACE 1,2,EAST
MOVE
LEFT
REPORT
```

Output

```
Robot is at (2, 2) facing NORTH
```
