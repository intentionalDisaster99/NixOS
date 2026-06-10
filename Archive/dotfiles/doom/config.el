;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;; 1. Make Org look more like a modern editor (Obsidian style)
(setq org-hide-emphasis-markers t)  ; Hide the *bold* and /italic/ syntax markers
(setq org-ellipsis " ▼ ")           ; Replace the "..." on folded headings with a nice arrow

;; 2. Enable Line Numbers only in programming modes (relative numbers for Vim users!)
(setq display-line-numbers-type 'relative)
(add-hook! 'prog-mode-hook (display-line-numbers-mode 1))
(add-hook! 'org-mode-hook (display-line-numbers-mode -1)) ; Turn off line numbers in notes

;; 3. Physics/Math: Auto-render LaTeX equations in notes
;;    This lets you see the math symbols instead of just $$ \alpha $$
;; (add-hook 'org-mode-hook 'org-latex-preview-auto-mode)

;; Trying to get it to automatically show previews for math
(setq org-startup-with-latex-preview t)
;; 1. Hiding Syntax (The "Live Preview" look)
(setq markdown-hide-urls t)      ; Hide big URLs like [Name](http://...)
(setq markdown-hide-markup t)    ; Hide *bold* and _italic_ markers
(setq markdown-fontify-code-blocks-natively t) ; Highlight code inside ```blocks```

;; 2. Make it look like a Document, not Code (Mixed Pitch)
;;    This makes regular text use your UI font (Sans Serif),
;;    but keeps tables and code blocks in Monospace.
(add-hook! 'markdown-mode-hook
  (mixed-pitch-mode 1)
  (display-line-numbers-mode -1)) ; Hide line numbers for a cleaner reading experience
(after! org (setq org-startup-with-latex-preview t))
(setq display-line-numbers-type 'relative)  ;; line numbers relative to current line Hopefully for org mode
