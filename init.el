;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; display “lambda” as “λ”
(global-prettify-symbols-mode 1)

;; Set path to dependencies '~/home/.emacs.d/site-lisp'
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

;; '~/home/.emacs.d/settings'
(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

;; Set up load path
(add-to-list 'load-path settings-dir)
(add-to-list 'load-path site-lisp-dir)

;; site-lisp major modes
;; settings appearance, key-bindings, setups

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)


;; Add external projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))


;; Set up appearance early
(require 'appearance)

;; Setup packages
(require 'setup-package)


;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

;; Install extensions if they're missing
(defun init--install-packages ()
  (packages-install
   '(yasnippet
     js2-mode
     ac-js2
     js2-refactor
    )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Setup extensions
(require 'setup-yasnippet)

;; Language specific setup files
(eval-after-load 'js2-mode '(require 'setup-js2-mode))

;; Map files to modes -> js2-mode, python-mode...
(require 'mode-mappings)
