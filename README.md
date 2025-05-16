# Toy Robot Simulator

The Toy Robot Simulator is a command-line application that simulates a toy robot moving on a 5x5 tabletop grid. The robot can be placed, moved, rotated, and asked to report its position, all while respecting the table's boundaries.

## Requirements

- Ruby 3.0+
- Make the script executable: `chmod +x toy_robot_simulator`

## Running Tests

This project uses [RSpec](https://rspec.info/) for testing.

To run the test suite:

```bash
bundle install
rspec
```

## Example

```bash
$ ./toy_robot_simulator
ToyRobot REPL started. Type commands or 'EXIT' to quit.
> PLACE 0,0,NORTH
> MOVE
> REPORT
Robot is at (0, 1) facing NORTH
```

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
./toy_robot_simulator --file commands.txt
```

**Command File Format**

The command file should contain one command per line, such as:

```plaintext
PLACE 0,0,NORTH
MOVE
LEFT
REPORT
```

**REPL Mode**

Start an interactive session to control the robot manually:

```bash
./toy_robot_simulator
```

```plaintext
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

## Contributing

Contributions are welcome! If you'd like to improve the simulator or add new features, feel free to fork the repo and open a pull request.

Please ensure your changes are tested and follow the existing code style (Rubocop-friendly).

1. Fork the project
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request
