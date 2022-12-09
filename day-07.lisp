;; day-07.lisp

(in-package #:aoc-2022)

(defparameter *cd-up-regex* "\\$ cd \\.\\.")
(defparameter *cd-down-regex* "\\$ cd (.+)")

(defparameter *ls-regex* "\\$ ls")

(defparameter *dir-regex* "dir (.+)")
(defparameter *file-regex* "([0-9]+) (.+)")

(defsolution (input-file) 7 1
  (with-open-file (in input-file)
    (let ((tree '()))
      (loop for line = (read-line in)
	    while line))))
