#Tic Tac Toe

Code kata for ruby practice

This is playable on the command line. 

The final version of the game uses the Negamax Algorithm with alpha-beta
pruning. Older commits show that I tried to incorporate move ordering, but
benchmarks showed my implementation to be detrimental and as such was not kept
in the ai code. 

Clone the repo:

```shell
$ git clone https://github.com/nickbdyer/tictactoe.git
```

To play the game:

```shell
$ cd tictactoe
$ ./run.rb
```
It is also possible to run the game 2x2 and 4x4 sized boards:

```shell
$ ./run.rb 2
$ ./run.rb 4
```
*Note:* 2x2 games are very boring. And until I implement transposition tables,
the 4x4 Ai is extremely slow (at least 15 minutes, I got bored and quit) at the
start of the game. 

To run the test suite:
```shell
$ rspec
```

Code coverage can then be seen in:
```shell
$ open coverage/index.html
```

