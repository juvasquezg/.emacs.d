;; =============
;; irony-mode
;; =============
(require 'irony)


;; load irony-mode

(setq w32-pipe-read-delay 0)



;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'company-irony)
  (define-key irony-mode-map [remap complete-symbol]
    'company-irony))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
;; load .clang
;;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(provide 'setup-irony)
