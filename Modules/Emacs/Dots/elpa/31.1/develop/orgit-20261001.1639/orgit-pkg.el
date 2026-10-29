;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "orgit" "20261001.1639"
  "Support for Org links to Magit buffers."
  '((emacs    "29.1")
    (compat   "31.1")
    (cond-let "1.1")
    (llama    "1.0")
    (magit    "4.7")
    (org      "9.8"))
  :url "https://github.com/magit/orgit"
  :commit "5e5110393e73513571a55e8ca93894dd4629bc00"
  :revdesc "5e5110393e73"
  :keywords '("hypermedia" "vc")
  :authors '(("Jonas Bernoulli" . "emacs.orgit@jonas.bernoulli.dev"))
  :maintainers '(("Jonas Bernoulli" . "emacs.orgit@jonas.bernoulli.dev")))
