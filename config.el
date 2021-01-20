;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Andrew Knowles"
      user-mail-address "andrew.knowles@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "JetBrains Mono" :size 15 :weight 'light)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 15 :weight 'light))

;; (set-face-attribute 'mode-line nil :font "JetBrains Mono 14")


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
(add-to-list 'command-switch-alist '("(make-frame-visible)" .
			             (lambda (s))))

(require 'server)
(if (not (server-running-p)) (server-start))

(defun my-done ()
  "Exit server buffers and hide the main Emacs window"
  (interactive)
  (server-edit)
  (make-frame-invisible nil t))

(global-set-key (kbd "C-x C-c") 'my-done)
(global-set-key (kbd "C-M-c") 'save-buffers-kill-emacs)

(setq doom-theme 'doom-dark+)

(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")

(setq elpy-rpc-python-command "python")

(setq neo-smart-open t)

(map! "<C-S-n>" #'helm-mini
      "<C-S-p>" #'helm-projectile
      "<f5>" #'neotree-toggle
      "<f11>" #'previous-buffer
      "<f12>" #'next-buffer
      "<C-M-s-,>" #'nil
      )


(global-set-key (kbd "C-S-n") #'helm-mini)
(global-set-key (kbd "C-S-p") #'helm-projectile)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(after! org
  (setq org-todo-keywords '((sequence "TODO(t)" "IN PROGRESS(i)" "|" "DONE(d)" "SKIPPED(s)")))
  )

(projectile-global-mode)

(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(setq neo-window-width 75)

(setq projectile-globally-ignored-directories
      (quote
       (".idea" ".eunit" ".git" ".hg" ".svn" ".fslckout" ".bzr" "_darcs" ".tox" "build" "target" "gems")))

(use-package shadowenv
  :ensure t
  :hook (after-init . shadowenv-global-mode))

(doom-themes-neotree-config)
(setq doom-themes-neotree-file-icons "doom-colors")
(doom-themes-org-config)

(use-package web-mode
  :custom
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2))

(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)

(setq dumb-jump-force-searcher 'rg)

(setq ispell-dictionary "en")
(setq aspell-dictionary "en")

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook #'rainbow-mode)
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))
(super-save-mode +1)
(setq super-save-auto-save-when-idle t)
