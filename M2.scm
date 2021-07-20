(define (m2-aux string current-state)
	(cond
		((equal? (string->list string) '())
			(if (= current-state 1)
				(display "this string has been accepted!")
				(display "this string has been rejected.")))
		((equal? (car (string->list string)) #\0)
			(cond
				((= current-state 0)
					(m2-aux (list->string (cdr (string->list string))) 0))
				((= current-state 1)
					(m2-aux (list->string (cdr (string->list string))) 0))))
		((equal? (car (string->list string)) #\1)
			(cond
				((= current-state 0)
					(m2-aux (list->string (cdr (string->list string))) 1))
				((= current-state 1)
					(m2-aux (list->string (cdr (string->list string))) 1))))
		(else
			(display "the string must contain only 1s or 0s!"))))

(define (m2 string)
	(m2-aux string 0))