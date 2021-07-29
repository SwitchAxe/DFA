(import (rnrs exceptions))
(display "Welcome to N2! This automaton expects a string consisting of 0s and ")
(display "\n 1s and it accepts if the number of changes from 0 to 1 is even.")
(display "\n For example 1011 is accepted while 1000 is not. Have fun!")
;;This automaton works differently regarding its interaction with the input, as it 
;;apparently requires some sort of branching to work out. The automaton has two simmetrical 
;;branches originating from the start node (state) and it uses the first input symbol to determine
;;which path to choose. In any case, it can't go back to the start state, nor can it choose to go
;;in a different path. So we need a `branch` variable (which i conveniently expressed as a 
;;function parameter) to keep track of the branch we're in, and act accordingly.  
;;The 0 branch is the default one, that is: no branch at all, it's when the machine has just
;;started and it hasn't read a symbol yet. the first branch (1) is the upper (left) one, while
;;the second (2) one is the last branch, that is: the lower (right) one.
(define (n2-aux string current-state branch)
	(cond
		((null? (string->list string))
			(if (or (zero? current-state) (= current-state 1) (= current-state 3))
				(display "This string has been accepted!")
				(display "This string has been rejected.")))
		((equal? (car (string->list string)) #\0)
			(cond
				((zero? branch) (n2-aux (list->string (cdr (string->list string))) 1 1))
				((= branch 1) (n2-aux (list->string (cdr (string->list string))) 1 1))
				((= branch 2) (n2-aux (list->string (cdr (string->list string))) 4 2))))
		((equal? (car (string->list string)) #\1)
			(cond
				((zero? branch) (n2-aux (list->string (cdr (string->list string))) 3 2))
				((= branch 1) (n2-aux (list->string (cdr (string->list string))) 2 1))
				((= branch 2) (n2-aux (list->string (cdr (string->list string))) 3 2))))
		(else
			(raise
				(condition
					(make-error)
					(make-message-condition "The string must only contain 1s or 0s!"))))))
 
(define (n2 string)
	(cond
		((string? string) (n2-aux string 0 0))
		(else
			(raise
				(condition
					(make-error)
					(make-message-condition "this automaton expects a string!"))))))
