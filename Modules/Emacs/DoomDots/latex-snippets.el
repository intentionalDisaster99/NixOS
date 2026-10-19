;;; Modules/Emacs/Dots/latex-snippits.el -*- lexical-binding: t; -*-

;; =============================================================================
;; 1. Add (package! aas) to your ~/.config/doom/packages.el file first!
;; 2. Copy the code below into your ~/.config/doom/config.el
;; =============================================================================

(defun my/in-math-p ()
  "Check if point is inside a LaTeX math fragment in Org mode."
  (or (and (fboundp 'org-inside-LaTeX-fragment-p) (org-inside-LaTeX-fragment-p))
      (and (fboundp 'texmathp) (texmathp))
      (let ((faces (ensure-list (get-text-property (point) 'face))))
        (memq 'org-latex-and-related faces))))

(defun my/latex-auto-fraction ()
  "Smart fraction trigger: Converts previous word/selection to \frac{word}{}."
  (interactive)
  (if (not (my/in-math-p))
      (insert "/")
    (cond
     ;; Case 1: Active region selection
     ((use-region-p)
      (let ((text (buffer-substring (region-beginning) (region-end))))
        (delete-region (region-beginning) (region-end))
        (insert (format "\frac{%s}{}" text))
        (backward-char 1)))
     ;; Case 2: Preceding word/symbol
     ((looking-back "[a-zA-Z0-9_^{\}\]+" (line-beginning-position))
      (let ((pt (point)))
        (skip-chars-backward "a-zA-Z0-9_^{}\\")
        (let ((word (buffer-substring (point) pt)))
          (delete-region (point) pt)
          (insert (format "\frac{%s}{}" word))
          (backward-char 1))))
     ;; Case 3: Empty fraction
     (t
      (insert "\frac{}{}")
      (backward-char 1)))))

(use-package! aas
  :hook (org-mode . aas-activate-for-type)
  :config
  ;; Define auto-expanding LaTeX snippets for Org mode
  (aas-set-snippets 'org-mode
                    :cond #'my/in-math-p

                    ;; Auto Fraction (press / anywhere in math mode)
                    "/" #'my/latex-auto-fraction

                    ;; Roots & Powers
                    "sq"  (lambda () (interactive) (insert "\\sqrt{}") (backward-char 1))
                    "sr"  "^{2}"
                    "cb"  "^{3}"
                    "td"  (lambda () (interactive) (insert "^{}") (backward-char 1))
                    "rd"  (lambda () (interactive) (insert "^{()}") (backward-char 2))
                    "_"   (lambda () (interactive) (insert "_{}") (backward-char 1))

                    ;; Common Math Symbols & Modifiers
                    "inf" "\\infty"
                    "vec" (lambda () (interactive) (insert "\\vec{}") (backward-char 1))
                    "bar" (lambda () (interactive) (insert "\\overline{}") (backward-char 1))
                    "hat" (lambda () (interactive) (insert "\\hat{}") (backward-char 1))
                    "abs" (lambda () (interactive) (insert "\\left|  \\right|") (backward-char 8))
                    "norm" (lambda () (interactive) (insert "\\left\\|  \\right\\|") (backward-char 9))

                    ;; Operators & Matrices
                    "int" (lambda () (interactive) (insert "\\int_{}^{} \\, dx") (search-backward "_{}" nil t) (forward-char 2))
                    "sum" (lambda () (interactive) (insert "\\sum_{n=1}^{\\infty} ") (backward-char 11))
                    "lim" (lambda () (interactive) (insert "\\lim_{x \\to \\infty} ") (backward-char 14))
                    "pmat" (lambda () (interactive) (insert "\\begin{pmatrix}\n\n\\end{pmatrix}") (forward-line -1))
                    "bmat" (lambda () (interactive) (insert "\\begin{bmatrix}\n\n\\end{bmatrix}") (forward-line -1))
                    "==" "&= "))
