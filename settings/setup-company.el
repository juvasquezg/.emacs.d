;; company-mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony 'company-c-headers))

(provide 'setup-company)
