# DFA
Some deterministic finite-state automata i've written in scheme. Taken directly from the book "Introduction to the theory of computation" by Michael Sipser.

# Running the automata  
(tested on chez-scheme) to run the automata, you just choose the file you want to run (each file is self-contained, meaning each automaton will
be in a separate file) and run `scheme file.scm`. To run the first automaton, for instance, you would write `scheme M1.scm`.
each automaton is written in a function that has its name, just lowercase. So for M1 the corresponding function is called `m1` and every automaton takes a single
string in input.
