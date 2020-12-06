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
(setq doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

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

(setq doom-theme 'doom-tomorrow-night)

(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")

(setq elpy-rpc-python-command "python")

(map! "<C-S-n>" #'helm-mini
      "<C-S-p>" #'helm-projectile
      "<f5>" #'neotree-toggle
      "<f11>" #'previous-buffer
      "<f12>" #'next-buffer
      )

(global-set-key (kbd "C-S-n") #'helm-mini)
(global-set-key (kbd "C-S-p") #'helm-projectile)
(global-set-key (kbd "C-S-t") #'neotree-toggle)

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(projectile-global-mode)

(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
