Debugging perl with vim
==================================

Installation
----------------------------------

See: [Vim::Debug::Manual - search.cpan.org](http://search.cpan.org/perldoc?Vim%3A%3ADebug%3A%3AManual)

```bash
cpan
install Vim::Debug
vimdebug-install -d ~/.vim
```

Operation
----------------------------------

```
<F6>       Step out
<F7>       Step into
<F8>       Next

<F9>       Continue
<F10>      Restart debugger. Break points are ALWAYS saved (for all dbgrs).
<F11>      Exit the debugger
<F12>      Start the debugger

<Leader>b  Set break point on the current line
<Leader>c  Clear break point on the current line

<Leader>v  Print the value of the variable under the cursor
<Leader>v/ Print the value of an expression thats entered

<Leader>/  Type a command for the debugger to execute and echo the result
```

### Useful debugger commands

p EXPR - prints the value of the expression EXPR
x EXPR - Dumps  the value of the expression EXPR

