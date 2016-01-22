;;; setup-js2-mode.el --- tweak js2 settings -*- lexical-binding: t; -*-



;; Let flycheck handle parse errors

;; two size Indent
(setq js2-basic-offset 4)
;; Disable semicolon Warning
(setq js2-strict-missing-semi-warning nil)

(provide 'setup-js2-mode)
