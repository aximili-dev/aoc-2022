;;;; aoc-2022.lisp

(in-package #:aoc-2022)

(defparameter *solutions* '())

(defun run-solution (day puzzle input)
  (let ((solution (cdr (assoc `(,day . ,puzzle) *solutions*
			      :test #'equal))))
    (funcall solution input)))

(defmacro register-solution (day puzzle fun-name)
  `(push (cons (cons ,day ,puzzle) (function ,fun-name)) *solutions*)) 
