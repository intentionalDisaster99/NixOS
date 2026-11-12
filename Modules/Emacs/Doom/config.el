;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(add-to-list 'custom-theme-load-path (expand-file-name "theme" doom-user-dir))
(setq doom-theme 'noctalia)

(setq user-full-name "Sam Whitlock"
      user-mail-address "abyssalflerken@gmail.com")

(setq shell-file-name (executable-find "bash"))
(setq-default vterm-shell "/run/current-system/sw/bin/fish")
(setq-default explicit-shell-file-name "/run/current-system/sw/bin/fish")

(setq fancy-splash-image
      (concat doom-private-dir "splash/I-am-doom-small.png"))

(setq display-line-numbers-type 'relative)

(setq! desktop-load-locked-desktop t)
(setq auto-save-visited-interval 1)
(auto-save-visited-mode 1)

(load! "treemacs-config.el")

(use-package pdf-tools
  :init
  (pdf-tools-install))

(use-package! wakatime-mode
  :hook (doom-first-buffer . global-wakatime-mode)
  :config
  (setq wakatime-cli-path (executable-find "wakatime-cli"))
  (setq wakatime-api-key
        (string-trim (shell-command-to-string "wakatime-cli --config-read api_key"))))

;; (add-hook 'after-init-hook 'global-company-mode)

(after! org
  (setq org-directory "~/Brain")
  (setq org-agenda-files
        (seq-remove (lambda (file)
                      (string-match-p "\\.stversions\\|sync-conflict" file))
                    (directory-files-recursively org-directory "\\.org$"))))

(defun toggle-background-transparency ()
  "Toggle background transparency, wherein text and other elements in frame are still displayed but a background isn't."
  (interactive)
  (if (get 'toggle-background-transparency 'state)
      (progn
        (set-frame-parameter nil 'alpha-background 100)
        (put 'toggle-background-transparency 'state nil))
    (progn
      (set-frame-parameter nil 'alpha-background 75)
      (put 'toggle-background-transparency 'state t))))

(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("◉" "○" "◈" "◇")))

(use-package! org-fragtog
  :hook (org-mode . org-fragtog-mode))
(after! org
  (setq org-format-latex-options
        (plist-put org-format-latex-options :scale 1)))
(after! org
  (setq org-startup-with-latex-preview t))
(after! org
  (setq org-preview-latex-default-process 'dvisvgm))

(use-package! texfrag
  :hook (markdown-mode . texfrag-mode))
(use-package! math-preview
  :commands (math-preview-all math-preview-clear-all
                              math-preview-at-point math-preview-region)
  :config
  (setq math-preview-scale 1))

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
          (:name "Due in Future"
           :deadline future)
          (:name "Waiting"
           :todo "WAIT"))))

(after! org
  (setq org-priority-highest ?A
        org-priority-lowest  ?F
        org-priority-default ?C))

(after! org
  (setq org-default-notes-file "~/Brain/org/inbox.org"
        +org-default-todo-file "~/Brain/org/inbox.org")
  (setq org-capture-templates
        '(("t" "Todo Task" entry
           (file "~/Brain/org/inbox.org")
           "* TODO %?\n  CREATED: %U" :empty-lines 1)
          ("n" "Note / Idea" entry
           (file "~/Brain/org/inbox.org")
           "* %?\n  CREATED: %U" :empty-lines 1))))

(map! :leader
      :desc "Capture a todo"
      "z" (lambda () (interactive) (org-capture nil "t")))

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-auto-links t
        org-appear-auto-emphasis t))

;; Nothing to see here
