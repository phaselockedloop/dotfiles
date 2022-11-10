(doom! :input
       :completion
       helm
       :ui
       doom
       (emoji +unicode)
       hl-todo
       ligatures
       modeline
       neotree
       (popup +defaults)
       vc-gutter
       vi-tilde-fringe
       workspaces
       :editor
       (evil +everywhere)
       :emacs
       dired
       electric
       undo
       vc
       :term
       :checkers
       :tools
       lookup
       magit
       :os
       (:if IS-MAC macos)
       :lang
       markdown
       org
       sh
       yaml
       :config
       (default +bindings +smartparens))
