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

(after! ws-butler
  (setq ws-butler-keep-whitespace-before-point t
        ws-butler-trim-predicate
        (lambda (beg end)
          (let ((current-line (line-number-at-pos)))
            (not (and (<= (line-number-at-pos beg) current-line)
                      (<= current-line (line-number-at-pos end))))))))

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

(use-package! beacon
  :config (beacon-mode 1))

(after! org
  (setq org-directory "~/Brain")
  (setq org-agenda-files
        (seq-remove (lambda (file)
                      (string-match-p "\\.stversions\\|sync-conflict" file))
                    (directory-files-recursively org-directory "\\.org$"))))

(after! org
  (setq org-directory "~/Brain")
  (setq org-agenda-files
        (seq-remove (lambda (file)
                      (string-match-p
                       "\\.stversions\\|sync-conflict\\|/\\(shoppingList\\|wishList\\)\\.org$"
                       file))
                    (directory-files-recursively org-directory "\\.org$"))))

(after! org-agenda
  (setq org-agenda-custom-commands
        '(("s" "Shopping List" todo ""
           ((org-agenda-files
             (seq-remove (lambda (file)
                           (string-match-p "\\.stversions\\|sync-conflict" file))
                         (directory-files-recursively org-directory "^shoppingList\\.org$")))
            (org-agenda-overriding-header "Shopping List")
            (org-super-agenda-groups nil)))
          ("w" "Wish List" todo ""
           ((org-agenda-files
             (seq-remove (lambda (file)
                           (string-match-p "\\.stversions\\|sync-conflict" file))
                         (directory-files-recursively org-directory "^wishList\\.org$")))
            (org-agenda-overriding-header "Wish List")
            (org-super-agenda-groups nil))))))

(defun my/insert-class-notes-template ()
  "Populate empty .org files inside Class Notes folders under ~/Brain/Main/School."
  (when (and buffer-file-name
             (string-equal (file-name-extension buffer-file-name) "org")
             (= (buffer-size) 0))
    (let* ((school-dir (file-name-as-directory
                        (file-truename (expand-file-name "~/Brain/Main/School"))))
           (file-dir (file-name-directory
                      (file-truename (expand-file-name buffer-file-name))))
           (parent-name (file-name-nondirectory (directory-file-name file-dir)))
           (class-dir (file-name-directory (directory-file-name file-dir))))
      (when (and (string-equal parent-name "Class Notes")
                 (string-prefix-p school-dir class-dir)
                 (not (string-equal school-dir class-dir)))
        (let* ((course (file-name-nondirectory (directory-file-name class-dir)))
               (raw-title (file-name-base buffer-file-name))
               (title (capitalize (replace-regexp-in-string "[-_]+" " " raw-title))))
          (insert (format "#+TITLE: %s\n" title)
                  (format "#+SUBTITLE: %s\n" course)
                  (format "#+AUTHOR: %s\n" user-full-name)
                  (format "#+DATE: %s\n" (format-time-string "[%Y-%m-%d %a]"))
                  "#+OPTIONS: toc:2 num:nil\n\n"
                  "* Action Items\n"
                  "- \n\n"
                  "* Main\n"
                  "** \n\n"
                  "* Off Topic\n")
          (goto-char (point-min))
          (search-forward "** " nil t))))))

(add-hook 'find-file-hook #'my/insert-class-notes-template)

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

(map! :leader
      :desc "Toggle transparency"
      :n :i :v "t t" #'toggle-background-transparency)

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

(use-package! platformio-mode
  :hook (c++-mode . platformio-conditionally-enable)
  :config
  (map! :localleader
        :map platformio-mode-map
        "b" #'platformio-build
        "u" #'platformio-upload
        "m" #'platformio-device-monitor
        "c" #'platformio-clean
        "i" #'platformio-init-update-workspace))

(add-to-list 'auto-mode-alist '("\\.rs\\'" . rustic-mode))
