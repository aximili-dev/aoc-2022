;;;; aoc-2022.asd

(asdf:defsystem #:aoc-2022
  :description "Describe aoc-2022 here"
  :author "Daniel Litvak"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (:cl-ppcre)
  :components ((:file "package")
               (:file "aoc-2022")
	       (:file "day-01")
	       (:file "day-02")
	       (:file "day-03")))
