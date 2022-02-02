#lang racket

;; lambda.occurs-free?: Symbol x LcExp -> Bool
;; usage: (lambda.occurs-free? var exp) = returns #t if the symbol var occurs free in exp
(define lambda.occurs-free?
  (lambda (var exp)
    (cond
      [(symbol? exp) (eqv? exp var)]
      [(eqv? (car exp) 'lambda) (and
                                 (not (eqv? (caadr exp) var))
                                 (lambda.occurs-free? var (caddr exp)))]
      [else (or
             (lambda.occurs-free? var (car exp))
             (lambda.occurs-free? var (cadr exp)))])))

; LcExp ::= var
;       ::= (lambda (var) LcExp
;       ::= (LcExp LcExp)
; (lambda calculus expression)


; > (lambda.occurs-free? 'x 'x)
; #t
; > (lambda.occurs-free? 'x 'y)
; #f
; > (lambda.occurs-free? 'x '(lambda (x) (x y)))
; #f
; > (lambda.occurs-free? 'x '(lambda (y) (x y)))
; #t
; > (lambda.occurs-free? 'x '((lambda (x) x) (x y)))
; #t
; > (lambda.occurs-free? 'x '(lambda (y) (lambda (z) (x (y z)))))
; #t
