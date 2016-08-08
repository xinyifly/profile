;;; package --- light
;;; Commentary:
;;; Code:

(require-package 'geben)
(require-package 'puppet-mode)
(require-package 'dockerfile-mode)
(require-package 'nginx-mode)
(require-package 'graphviz-dot-mode)
(require-package 'ace-jump-mode)

(define-key global-map (kbd "C-, C-,") 'ace-jump-mode)
(define-key global-map (kbd "C-, r") 'rename-buffer)
(define-key global-map (kbd "C-, e") 'eshell)
(define-key global-map (kbd "C-, t") 'ansi-term)
(define-key global-map (kbd "C-, s") 'scratch)

(set-face-attribute 'default nil :font "Noto Mono")
(set-fontset-font t 'unicode (font-spec :family "WenQuanYi Zen Hei Mono"))
(setq face-font-rescale-alist '(("WenQuanYi Zen Hei Mono" . 1.2)))

(setq org-latex-preview-ltxpng-directory "/tmp/ltxpng/")
(add-hook 'org-mode-hook
          (lambda () (plist-put org-format-latex-options :scale 2)))
(add-hook 'org-mode-hook
          (lambda () (local-unset-key (kbd "C-,"))))

(menu-bar-mode -1)

(add-hook 'c-mode-common-hook
          (lambda () (c-toggle-hungry-state 1)))

(provide 'init-local)
;;; init-local.el ends here
