
;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; display “lambda” as “λ”
(global-prettify-symbols-mode 1)

;; set encode
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; no Backup files
(setq make-backup-files nil)

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
	 auto-complete
    )))

(condition-case nil
    (init--install-packages)
  (error
   (package-refresh-contents)
   (init--install-packages)))

;; Setup extensions
(require 'setup-yasnippet)
(require 'setup-ac)
(require 'setup-company)
(require 'setup-irony)

;; Language specific setup files
(eval-after-load 'js2-mode '(require 'setup-js2-mode))
(eval-after-load 'cc-mode '(require 'setup-cc-mode))

;; Map files to modes -> js2-mode, python-mode...
(require 'mode-mappings)


(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

;;; Refactor please
;; really IDE ecb
(require 'ecb)

;; Setup key bindings
(require 'key-bindings)

;; Refactor jade and stylus mode
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))


;; emmet mode
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'web-mode-hook 'emmet-mode) ;; Auto-Start on web-mode
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(setq emmet-move-cursor-between-quotes t) ;; default nil first empty quote after expading

;;(add-hook 'emmet-mode-hook (lambda () (setq emmet-indent-after-insert nil)))
;;(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces.


;; web mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; disable call lineup
(add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))

;; custom web mode
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; HTML element offset indentation
(setq web-mode-markup-indent-offset 2)

;; CSS offset indentation
(setq web-mode-css-indent-offset 2)

;; Script/code offset indentation (for JavaScript, Java, PHP, Ruby, VBScript, Python, etc.)
(setq web-mode-code-indent-offset 2)

;; Server comments
(setq web-mode-comment-style 2)

;; Highlight current HTML element
(setq web-mode-enable-current-element-highlight t)
