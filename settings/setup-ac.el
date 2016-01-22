(setenv "LD_LIBRARY_PATH" "C:/Program Files/LLVM/lib/")
;; Autocomplete
(autoload 'auto-complete-mode "auto-complete" nil t)
;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
;(ac-set-trigger-key "TAB")
;(ac-set-trigger-key "<tab>")
;; Auto-complete C/C++ header file names
(add-hook 'c-mode-common-hook
      (lambda()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"C:/Program Files/mingw-w64/x86_64-5.2.0-posix-seh-rt_v4-rev1/mingw64/x86_64-w64-mingw32/include")))

(provide 'setup-ac)
