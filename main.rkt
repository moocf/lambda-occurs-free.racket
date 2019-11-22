#lang racket

;; occurs-free?: Symbol x LcExp -> Bool
;; usage: (occurs-free? var exp) = returns #t is the symbol var occurs free in exp
(define occurs-free?
  (lambda (var exp)
    (cond
      [(symbol? exp) (eqv? exp var)]
      [(eqv? (car exp) 'lambda) (and
                                 (not (eqv? (caadr exp) var))
                                 (occurs-free? var (caddr exp)))]
      [else (or
             (occurs-free? var (car exp))
             (occurs-free? var (cadr exp)))])))

; LcExp ::= var
;       ::= (lambda (var) LcExp
;       ::= (LcExp LcExp)
; (lambda calculus expression)


; > (occurs-free? 'x 'x)
; #t
; > (occurs-free? 'x 'y)
; #f
; > (occurs-free? 'x '(lambda (x) (x y)))
; #f
; > (occurs-free? 'x '(lambda (y) (x y)))
; #t
; > (occurs-free? 'x '((lambda (x) x) (x y)))
; #t
; > (occurs-free? 'x '(lambda (y) (lambda (z) (x (y z)))))
; #t
