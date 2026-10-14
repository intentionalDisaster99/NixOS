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

;; Dynamically locate fish in PATH
(when-let ((fish-path (executable-find "fish")))
  (setq explicit-shell-file-name fish-path)
  (setq shell-file-name fish-path))

;; Set shell specifically for vterm / Doom popup terminal
(after! vterm
  (when-let ((fish-path (executable-find "fish")))
    (setq vterm-shell fish-path)))

;; Set shell for Ghostel
(after! ghostel
  (when-let ((fish-path (executable-find "fish")))
    (setq ghostel-shell fish-path)))


;; Rebind 'SPC e' to toggle Treemacs
(map! :leader
      :desc "Project sidebar" "e" #'treemacs)

;; Force Treemacs to open on the right side
(after! treemacs
  (setq treemacs-position 'right))


;; For automatic math rendering
;; (use-package! xenops
;;   :hook ((org-mode . xenops-mode)
;;          (markdown-mode . xenops-mode)))
;;


;; For latex snippet (duh)
(load! "latex-snippets.el")

(use-package! xenops
  :hook ((markdown-mode . xenops-mode)
         (gfm-mode . xenops-mode)
         (org-mode . xenops-mode))
  :config
  ;; Ensures xenops uses dvisvgm or dvipng depending on availability
  (setq xenops-math-image-scale-factor 1.5))

(after! org
  ;; Ensure default compiler and process are set to explicit strings
  (setq org-preview-latex-default-process 'dvisvgm)

  ;; Make sure background and foreground colors are valid strings or 'default
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1.5))
  (setq org-format-latex-options
        (plist-put org-format-latex-options :foreground 'default))
  (setq org-format-latex-options
        (plist-put org-format-latex-options :background 'default)))


(after! markdown-mode
  ;; Enable math rendering in markdown
  (setq markdown-enable-math t)

  ;; Force explicit string paths for latex and dvisvgm binaries on NixOS
  (setq markdown-latex-compiler "/etc/profiles/per-user/sa9m/bin/latex"
        markdown-latex-image-converter "/etc/profiles/per-user/sa9m/bin/dvisvgm"))

(after! org
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-startup-with-latex-preview t)
  (plist-put org-format-latex-options :scale 1))


;; Auto-save visited files after a second of idle time
(setq auto-save-visited-interval 1)
(auto-save-visited-mode +1)

;; Auto-open Treemacs sidebar when Doom starts
;; I actually don't love this so I removed it
;; (add-hook 'window-setup-hook #'treemacs)

;; Sync Treemacs with your current working directory and focused file
(after! treemacs
  (treemacs-follow-mode t)
  (treemacs-project-follow-mode t))

;; Open a directory when I use f d
(use-package! consult-dir
  :bind (("C-x C-d" . consult-dir)
         :map vertico-map
         ("C-x C-d" . consult-dir-jump-file-or-project)))

(map! :leader :desc "Find directory" "f D" #'consult-dir)

;; Keybinds that allow tab switching
(after! centaur-tabs
  (map! :map centaur-tabs-mode-map
        :n "C-H" #'centaur-tabs-backward
        :n "C-L" #'centaur-tabs-forward))

;; opens a new dired instance in the pwd in a new tab
(defun my/open-dired-pwd ()
  (interactive)
  (dired default-directory))

(map! :leader
      :desc "Open Dired in new tab" "t d" #'my/open-dired-pwd)


(after! centaur-tabs
  ;; Force all buffers onto a single tab bar regardless of directory or project
  (setq centaur-tabs-buffer-groups-function (lambda () '("All"))))

;; Keep opened files/projects within the current workspace
(setq +workspaces-on-switch-project-behavior nil)

;; Flash, just like in lazyvim <- I never actually got this to work, but whatever
;; (use-package! flash
;;   :commands (flash-jump flash-evil-jump)
;;   :init
;;   (map! :n "s" #'flash-evil-jump
;;         :v "s" #'flash-evil-jump)
;;   :config
;;   (require 'flash-evil)
;;   (flash-evil-setup t))

;; Enable relative line numbers globally
(setq display-line-numbers-type 'relative)

(after! org
  (defun my/org-justify-fragment-overlay (beg end image &optional imagetype)
    "Center standalone LaTeX fragment preview overlays using a before-string prefix."
    (save-excursion
      (goto-char beg)
      (let ((line-beg (line-beginning-position))
            (line-end (save-excursion (goto-char end) (line-end-position))))
        ;; Only apply to equations on their own line
        (when (and (string-blank-p (buffer-substring-no-properties line-beg beg))
                   (string-blank-p (buffer-substring-no-properties end line-end)))
          (dolist (ov (overlays-at beg))
            (let ((disp (overlay-get ov 'display)))
              ;; Add spacer to before-string instead of overwriting display property
              (when (and disp (eq (car-safe disp) 'image))
                (overlay-put ov 'before-string
                             (propertize " " 'display `(space :align-to (- center (0.5 . ,disp))))))))))))

  (advice-add 'org--make-preview-overlay :after #'my/org-justify-fragment-overlay)
  (advice-add 'org--format-latex-make-overlay :after #'my/org-justify-fragment-overlay))

;; Automatic math rendering
(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))
