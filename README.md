#Tic Tac Toe

Code kata for ruby practice

This is playable on the command line. 

The final version of the game uses the Negamax Algorithm with alpha-beta
pruning. Older commits show that I tried to incorporate move ordering, but
benchmarks showed my implementation to be detrimental and as such was not kept
in the ai code. There is potential to add transpositional tables, however,
I didn't feel as though the game was suffering due to ai computational time, so
opted not to implement this. 

All in all this was a great challenge, and a lot of fun to implement. 

Clone the repo:

```shell
$ git clone https://github.com/nickbdyer/tictactoe.git
```

To play the game:

```shell
$ cd tictactoe
$ ruby run.rb
```

To run the test suite:
```shell
$ rspec
```

Code coverage can then be seen in:
```shell
$ open coverage/index.html
```

