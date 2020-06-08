#lang racket
(define (guess i j)
  (println (quotient (+ i j ) 2))
  (let ([x (read)])
    (cond
      [(= (- i 1) j) j]
      [(equal? x 'e) (quotient (+ i j) 2)]
      [(equal? x 'g) (guess i (quotient (+ i j) 2))]
      [else (guess (quotient (+ i j) 2) j)]
      )
    )
  )

(symbol=? 'foo 'Foo) ; ' is used for making a symbol out of the remaining characters
(expt 53 53); Inbuilt Bignum support
(number? 2.2); returns true. Hence all complex numbers are treated as numbers 
;; for emphasising comment on a newline
;; All these make empty lists
empty
'()
(list)
'apoorv ; this is a symbol aka data , just apoorv would give syntax error
(cons 1 2); each list is basically made of cons cells a cons cell is a data+next structure kind of a node as in linked list basic to Racket hence list-ref takes O(n) time !
(cons 'apoorv '(1 2))

(println "Structures")
;;Structures in Racket
;; (struct StructName (space seperated fields))
(struct name (firstname secondname) #:transparent ); without transparent if you type myname in interpreter it would be #<name> but with it, it would show (name 'apoorv 'jain)
(define myname (name 'apoorv 'jain))
(println (name-firstname myname))
(name? myname) ; racket exposes various functions for the struct, eg set!, struct?
(struct point (x y))
(define pt1 (point 1 2))
(define pt2 (point 1 2))
(equal? pt1 pt2);; now gives false
(eq? pt1 pt2) ;; Check if the instances of the struct were made from the same CALL TO CONSTRUCTOR HENCE TWO DIFF INSTANCES ALWAYS FALSE BECAUSE MADE AT TWO DIFF. CALL
(struct point_t (x y) #:transparent)
(define pt1_t (point_t 1 2))
(define pt2_t (point_t 1 2))
(equal? pt1_t pt2_t) ;; now gives true
(eq? pt1_t pt2_t)
(define pt3_t pt1_t)
(eq? pt3_t pt1_t) ;; gives true because pt3_t is indeed pt1_t
#| While equal? checks whether two values consist of identical pieces (in terms of values),
eq? compares whether changing one structure changes the other structure (aka references (or pointers)),
and that happens only when the structures were created with the same exact call to the constructor;
(println "Conditions")
|#
;; Conditions cond is more Rackety; everything apart from #f is true hence '() (cons 1 2) (cdr '(1 2 3)) all are true

(if (> 1 2) '(1 is greater than 2 ) '(1 is smaller than)) 
(cond 
  [(> 1 2) '(1 is greater than 2)]
  [(< 1 2) '(1 is smaller than 2)]
  )
(if '() '(everything apart from #f is indeed #t) '(No some things can be false inspite not being #f))
(when (rest '(1 2 3)) '(yep solves and checks the condition as well. No false hence this is true !! )) ;; when is if without else
(unless #f '(Racket is so cool)) ; Racket being cool !! Unless is opposite of when

(member 1 '(2 4 5 1 6 7 )) ; gives tail from 1 onewards

;;Testing
(println "Testing")
;; Requires rackunit : (require rackunit)
(require rackunit)
(check-equal? 5 6 "Numbers matter");; would be giving FAILURE in the terminal along with a MESSAGE for additional debugging message, whereas if equal would do nothing
(check-not-equal? 5 6)
(check-pred number? 'apoorv)
(check-pred number? 1)
;; check-= evaluates whether a-b<= c where condition is (check-= c a b)
(check-= 1 1 2) ; (1-2) <=  1
(check-= 1 2 1); (2-1) <= 1
(check-= 1 2 2) ; (2-2) <= 1
(check-= -1 2 1) ; (2-2)> -1

(check-true (> 1 2) '(1 is smaller)) ; checkes if argument is #t (NOTE IT GIVES FAILURE IF ANYTHING APART FROM #t is present contrary to if
(check-false (> 2 1) '(2 is greater !))
(check-not-false (member 1 '(1 2 3))) ; since check-true only check #t hence this check for anything other than #f

(println "More about definitions")
;; Local Definitions
(define (func)
  (define x "apoorv")
  (print x)
  )
; x ;; note this gives unbound error because  (define x "apoorv") is local to the scope of func;
(define (func1)
  (print (let ([x 0]) ; let must have a return type if nothing has to be returned use define or return (void)
    x)))
(func1)
(display "\nHigh Order Functions\n")
;; High Order functions are those function whose return type or arguments are functions themselves. They exist in both C++, Python
(define (mymap func lst) ;; Implementation of the map function
  (cond
    [(empty? lst) '()]
    [else (cons (func (first lst)) (mymap func (rest lst)))]
    )
  )
(mymap add1 '(1 2 3 4))
(define (myfilter predicate lst) ;; Implementation of the map-filter function
  (cond
    [(empty? lst) '()]
    [(predicate (car lst)) (cons (car lst) (myfilter predicate (rest lst)))]
    [else (myfilter predicate (rest lst))]))
(myfilter (lambda (x) (> x 1)) '(1 2 3));; myfilter implementation
(map (lambda (x) (+ 1 x)) '(1 2 3 4)) ;; using map+lambda hence same effect as mymap and add1
(filter (lambda (x) ( > x 1)) '(1 2 3)) ;; using map-filter rather than myfilter
(lambda (x) (+ x 1)) ;; gives #<procedure> in interpreter
((lambda (x) (+ x 1)) 1) ;; hence the function has been evaluated on 1

;; other HOF are ormap, andmap, foldr
(apply max '(1 2 3 4 5)) ;; apply applies operator to all elements of list giving a cumulated answer
(apply + '(1 2 3 4 5))
