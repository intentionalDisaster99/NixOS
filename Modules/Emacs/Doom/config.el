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
;; Add local theme directory to custom-theme-load-path
(add-to-list 'custom-theme-load-path (expand-file-name "theme" doom-user-dir))

;; Set the active theme
(setq doom-theme 'noctalia)
;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
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


;; My Name
(setq user-full-name "Sam Whitlock"
      user-mail-address "abyssalflerken@gmail.com")

;; General config
(setq! desktop-load-locked-desktop t)
(setq auto-save-visited-interval 1)
(auto-save-visited-mode 1)
(setq display-line-numbers-type 'relative)

;; Funny
(setq fancy-splash-image
      (concat doom-private-dir "splash/I-am-doom-small.png"))

;; Treemacs
(load! "treemacs-config.el")


;; Unfortunately, pdf-tools is really annoying on nixos
(use-package pdf-tools
  :init
  (pdf-tools-install))

;; Math?
;; (use-package! texfrag
;;   :hook (markdown-mode . texfrag-mode))
(use-package! math-preview
  :commands (math-preview-all math-preview-clear-all
                              math-preview-at-point math-preview-region)
  :config
  (setq math-preview-scale 1))

(use-package! wakatime-mode
  :hook (doom-first-buffer . global-wakatime-mode)
  :config
  (setq wakatime-cli-path (executable-find "wakatime-cli"))
  (setq wakatime-api-key
        (string-trim (shell-command-to-string "wakatime-cli --config-read api_key"))))

;; Moving to brain instead of org
(after! org
  (setq org-directory "~/Brain")
  (setq org-agenda-files
        (seq-remove (lambda (file)
                      (string-match-p "\\.stversions\\|sync-conflict" file))
                    (directory-files-recursively org-directory "\\.org$"))))
;; Gantt charg my beloved
(map! :leader
      :desc "Elgantt timeline" "o a g" #'elgantt-open)

(use-package! elgantt
  :after org
  :config
  (require 'elgantt)

  (setq elgantt-agenda-files org-agenda-files
        elgantt-header-type 'outline
        elgantt-insert-header-even-if-no-timestamp nil
        elgantt-startup-folded nil
        elgantt-draw-overarching-headers t
        elgantt-header-column-offset 35)

  (setq elgantt-user-set-color-priority-counter 0)
  (elgantt-create-display-rule draw-scheduled-to-deadline
    :parser ((elgantt-color . ((when-let ((colors (org-entry-get (point) "ELGANTT-COLOR")))
                                 (s-split " " colors)))))
    :args (elgantt-scheduled elgantt-color elgantt-org-id)
    :body ((when elgantt-scheduled
             (let ((point1 (point))
                   (point2 (save-excursion
                             (elgantt--goto-date elgantt-scheduled)
                             (point)))
                   (color1 (or (car elgantt-color) "black"))
                   (color2 (or (cadr elgantt-color) "red")))
               (when (/= point1 point2)
                 (elgantt--draw-gradient
                  color1
                  color2
                  (if (< point1 point2) point1 point2)
                  (if (< point1 point2) point2 point1)
                  nil
                  `(priority ,(setq elgantt-user-set-color-priority-counter
                                    (1- elgantt-user-set-color-priority-counter))
                    :elgantt-user-overlay ,elgantt-org-id)))))))

  (after! evil
    (evil-set-initial-state 'elgantt-mode 'normal))

  (map! :map elgantt-mode-map
        :n "j"   #'evil-next-line
        :n "k"   #'evil-previous-line
        :n "h"   #'evil-backward-char
        :n "l"   #'evil-forward-char
        :n "J"   (cmd! (call-interactively (lookup-key elgantt-mode-map "F")))  ; Scroll month forward
        :n "K"   (cmd! (call-interactively (lookup-key elgantt-mode-map "B")))  ; Scroll month backward
        :n "g t" (cmd! (call-interactively (lookup-key elgantt-mode-map "c")))  ; Jump to today
        :n "g r" (cmd! (call-interactively (lookup-key elgantt-mode-map "g")))  ; Refresh chart
        :n "o"   (cmd! (call-interactively (lookup-key elgantt-mode-map " ")))  ; Jump to Org headline
        :n "RET" (cmd! (call-interactively (lookup-key elgantt-mode-map "\r"))))) ; Open Org Agenda at point

;; Org stuff
(setq org-directory "~/Brain/org/")

(setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))

(setq org-log-done 'time)
(setq org-log-into-drawer t)

(use-package! org-super-agenda
  :after org-agenda
  :config
  (org-super-agenda-mode 1)
  ;; Disable header keymap to prevent Evil movement conflicts
  (setq org-super-agenda-header-map nil)
  (setq org-super-agenda-groups
        '((:name "Today"
           :time-grid t
           :scheduled today)
          (:name "Important"
           :priority "A")
          (:name "Overdue"
           :deadline past)
          (:name "Due Soon"
           :deadline future)
          (:name "Waiting"
           :todo "WAIT"))))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "◈" "◇")))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-auto-links t
        org-appear-auto-emphasis t))

(after! org
  (setq org-priority-highest ?A
        org-priority-lowest  ?F
        org-priority-default ?C)) ; Default priority assigned when omitted
;; (use-package! org-fancy-priorities
;;   :hook (org-mode . org-fancy-priorities-mode)
;;   :config
;;   (setq org-fancy-priorities-list '("❗" "⚡" "⬆" "▶" "⬇" "☕")))


(after! org
  (setq org-default-notes-file "~/Brain/org/inbox.org"
        +org-default-todo-file "~/Brain/org/todo.org")
  (setq org-capture-templates
        '(("t" "Todo Task" entry
           (file "~/Brain/org/inbox.org")
           "* TODO %?\n  CREATED: %U" :empty-lines 1)
          ("n" "Note / Idea" entry
           (file "~/Brain/org/inbox.org")
           "* %?\n  CREATED: %U" :empty-lines 1))))
