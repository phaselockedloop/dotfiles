(load "~/dotfiles/custom.el" 'noerror)
(setq user-full-name "Andrew Knowles"
      user-mail-address "andrew.knowles@gmail.com")
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 18)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 18)
      doom-big-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 18)
      )
(setq org-directory "~/org/")
(setq display-line-numbers-type t)
(add-to-list 'command-switch-alist '("(make-frame-visible)" .
			                               (lambda (s))))
(require 'etags)
(require 'server)
(if (not (server-running-p)) (server-start))
(defun run-script-on-file (script-path)
  (interactive "FScript path: ")
  (let ((file-path (buffer-file-name)))
    (shell-command (concat script-path " " file-path))
    (revert-buffer :ignore-auto :noconfirm)))
(defun my-done ()
  "Exit server buffers and hide the main Emacs window"
  (interactive)
  (server-edit)
  (defun keep-duplicates-in-region-or-buffer ()
  "Keep only duplicate lines in the selected region, or the entire buffer if no region is selected."
  (interactive)
  (let* ((begin (if (use-region-p) (region-beginning) (point-min)))
         (end (if (use-region-p) (region-end) (point-max)))
         (lines (make-hash-table :test 'equal))
         duplicates)
    (save-excursion
      (goto-char begin)
      (while (< (point) end)
        (let ((line (buffer-substring-no-properties
                     (line-beginning-position)
                     (line-end-position))))
          (puthash line (1+ (gethash line lines 0)) lines)
          (forward-line 1))))
    (maphash (lambda (k v) (when (> v 1) (push k duplicates))) lines)
    (delete-region begin end)
    (goto-char begin)
    (dolist (line duplicates)
      (insert line "\n"))))(make-frame-invisible nil t))
(global-set-key (kbd "C-x C-c") 'my-done)
(global-set-key (kbd "C-M-c") 'save-buffers-kill-emacs)
(global-set-key (kbd "C-x C-k") 'run-script-on-file)
(setq doom-theme 'doom-megadark+)
(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")
(setq elpy-rpc-python-command "python")
(map! "<C-S-n>" #'helm-mini
      "<C-S-p>" #'helm-projectile
      "<f5>" #'treemacs
      "<f11>" #'previous-buffer
      "<f12>" #'next-buffer
      "<C-M-s-,>" #'nil
      )
(global-set-key (kbd "C-S-n") #'helm-mini)
(global-set-key (kbd "C-S-p") #'helm-projectile)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "IN PROGRESS(i)" "REVIEW(r)" "|" "DONE(d)" "SKIPPED(s)")))
  )
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq shell-file-name "/bin/sh")
(setq projectile-indexing-method 'alien)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-globally-ignored-directories
      (quote
       (".idea" ".eunit" ".git" ".hg" ".svn" ".fslckout" ".bzr" "_darcs" ".tox" "build" "target" "gems")))
(setq dumb-jump-force-searcher 'rg)
(setq ispell-dictionary "en")
(setq aspell-dictionary "en")
(add-hook! (prog-mode text-mode conf-mode special-mode) #'rainbow-delimiters-mode)
(add-hook! (prog-mode text-mode conf-mode special-mode) #'rainbow-mode)
(add-hook! (prog-mode text-mode conf-mode special-mode) #'hl-line-mode)
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(super-save-mode +1)
(setq super-save-auto-save-when-idle t)
(add-hook 'xref-backend-functions #'projectile-find-tag)
(map! :n "gd" (lambda() (interactive) (etags-select-find-tag-at-point)))
(map! :n "gu" (lambda() (interactive) (etags-select-find-tag)))
(map! "M-," #'pop-tag-mark)
(setq async-bytecomp-allowed-packages '(all))
(setq pop-up-windows nil)
(setq helm-projectile-fuzzy-match nil)
(setq helm-candidate-number-limit 100)
(setq projectile-indexing-method 'alien)
(global-so-long-mode -1)
(setq doom-inhibit-large-file-detection t)
(setq confirm-kill-emacs nil)
(setq large-file-warning-threshold nil)
(setq etags-select-go-if-unambiguous t)
(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))
(setq doom-modeline-vc-max-length 100)
(after! doom-modeline
  (remove-hook 'doom-modeline-mode-hook #'size-indication-mode) ; filesize in modeline
  (remove-hook 'doom-modeline-mode-hook #'column-number-mode)   ; cursor column in modeline
  (setq doom-modeline-vcs-max-length 150)
  (line-number-mode -1)
  (setq doom-modeline-buffer-encoding nil)
)
(fringe-mode '8)
(setq warning-minimum-level :error)
(global-evil-surround-mode 1)
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook (lambda() (setq gc-cons-threshold 1000000)))
(setq native-comp-async-report-warnings-errors nil)
(global-visual-line-mode t)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#444444")
(set-face-foreground 'highlight nil)
(setq outline-regexp " *")
(setq-default tab-width 2)
(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))
(setq gc-cons-threshold #x40000000)
(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       (lambda ()
                         (message "Garbage Collector has run for %.06fsec"
                                  (k-time (garbage-collect))))))
(with-eval-after-load 'doom-themes
  (doom-themes-treemacs-config))
(use-package! treemacs
  :defer t
  :config
  (setq doom-themes-treemacs-theme "doom-colors"))

(setq org-hide-emphasis-markers t)

(add-hook 'org-mode-hook
          (lambda ()
            (show-paren-mode -1)
            (electric-pair-mode -1)))

(add-hook 'org-mode-hook (lambda ()
                           (smartparens-mode -1)
                           (smartparens-strict-mode -1)))

(with-eval-after-load 'smartparens
  (add-hook 'org-mode-hook (lambda () (smartparens-mode -1))))

;; Ensure rainbow-mode is loaded
(with-eval-after-load 'rainbow-mode
  (add-hook 'org-mode-hook (lambda () (rainbow-mode -1))))

;; Ensure rainbow-delimiters-mode is loaded
(with-eval-after-load 'rainbow-delimiters
  (add-hook 'org-mode-hook (lambda () (rainbow-delimiters-mode -1))))

(add-hook 'org-mode-hook 'org-rainbow-tags-mode)

(use-package! org-rainbow-tags)

(setq initial-buffer-choice "~/Library/CloudStorage/GoogleDrive-andrew.knowles@shopify.com/My Drive/todo.org")

;; Set predefined frame geometry
(setq initial-frame-alist
      '((top . 45)      ;; Y-coordinate
        (left . 20)     ;; X-coordinate
        (width . 170)   ;; Width in characters
        (height . 89))) ;; Height in characters

(setq default-frame-alist
      '((top . 45)      ;; Y-coordinate
        (left . 20)     ;; X-coordinate
        (width . 170)   ;; Width in characters
        (height . 89))) ;; Height in characters

(setq org-startup-with-inline-images t)
