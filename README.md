# Conway's Game of Life in Elixir

[![Dockerfile build test status](https://github.com/asimos-bot/conway-game-of-life-elixir/workflows/Dockerfile/badge.svg)](https://github.com/asimos-bot/conway-game-of-life-elixir/actions/workflows/main.yml)

## Requirements

* __`make`__
* __`elixir`__

## How to Run

To run the project, just do `make run`.
If only `elixir` is installed and not make, do `elixirc life.ex; elixir -e Game.main`

You can also run it in docker. To build the `conway-game-of-life-elixir` image, just
do `make docker-build` and `make docker-run` to open a shell ready to execute the
program.

### How it Works

The program will ask for the name of the file with the initial grid, where
`0` is dead, `1` is alive, `2` is zombie and `E` is empty and any other characters
(except newline) are invalid and all lines and columns should all have the same length.

If the grid stabilizes before the given number of iterations, the execution will
stop and the output going to be like `Stabilizes on iteration = 10`, if the
program runs all of the iterations, the output will be like `Last Iteration 11`.

Each state of the grid is showed with its iteration number below.

## Examples

We got some examples from [Standford](https://web.stanford.edu/class/sts145/Library/life.pdf).

### `expansion_and_blinkers.txt`

Input:

```
000000000
000000000
000000000
000010000
000111000
000000000
000000000
000000000
000000000
```

Output:

The program will run all the given iterations, due to the blinker formation.

### `beehive.txt`

Input:

```
000000
000000
011110
000000
000000
```

Output:

```
000000
001100
010010
001100
000000
```

### `glider.txt`

Input:

```
01000000000000000
00100000000000000
11100000000000000
00000000000000000
...
00000000000000000
```

Output:

```
00000000000000000
...
00000000000000000
00000000000000011
00000000000000011
```

### `zombie.txt`

Input:

```
11000
11200
00011
00011
```

Output:

```
00000
00000
00000
00000
```

### `empty.txt`

```
EEEEEEEEEEEEEEEEEEEEEEE
E0100000000E0000000010E
E0010000000E0000000100E
E1110000000E0000000111E
E0000000000E0000000000E
E0000000000E00000E0000E
E0000000000E0000000000E
EEEEEEEEEEEEEEEEEEEEEEE
E0000000000E0000000000E
E0000000000E0000000000E
E0000000000E0000000000E
E1110000000E0000000111E
E0010000000E0000000100E
E0100000000E0000000010E
EEEEEEEEEEEEEEEEEEEEEEE
```

Output:

```
EEEEEEEEEEEEEEEEEEEEEEE
E0000000000E0000000000E
E0000000000E0000000000E
E0000000000E0000000000E
E0000000000E0000000000E
E0000110000E00000E0000E
E0000110000E0000000000E
EEEEEEEEEEEEEEEEEEEEEEE
E0000110000E0000110000E
E0000110000E0000110000E
E0000000000E0000000000E
E0000000000E0000000000E
E0000000000E0000000000E
E0000000000E0000000000E
EEEEEEEEEEEEEEEEEEEEEEE
```
