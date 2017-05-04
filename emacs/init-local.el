;;; package --- light
;;; Commentary:
;;; Code:

;;; pkg
(require-package 'geben)
(require-package 'puppet-mode)
(require-package 'dockerfile-mode)
(require-package 'nginx-mode)
(require-package 'graphviz-dot-mode)
(require-package 'restclient)
(require-package 'tldr)
(require-package 'docker)

;;; key
(global-set-key "\C-s" 'swiper)
(define-key global-map (kbd "C-, c") 'avy-goto-char)
(define-key global-map (kbd "C-, l") 'avy-goto-line)
(define-key global-map (kbd "C-, r") 'rename-buffer)
(define-key global-map (kbd "C-, e") 'eshell)
(define-key global-map (kbd "C-, t") 'ansi-term)
(define-key global-map (kbd "C-, s") 'scratch)
(define-key global-map (kbd "C-, i") 'imenu)
(define-key global-map (kbd "C-, p") 'org-pomodoro)
(global-unset-key (kbd "C-z"))

;;; ui

;; font
(set-face-attribute 'default nil :font "Noto Mono")
(set-fontset-font t 'unicode (font-spec :family "WenQuanYi Zen Hei Mono"))
(setq face-font-rescale-alist '(("WenQuanYi Zen Hei Mono" . 1.2)))

;;; org
(setq org-latex-preview-ltxpng-directory "/tmp/ltxpng/")
(add-hook 'org-mode-hook
          (lambda () (plist-put org-format-latex-options :scale 2)))
(add-hook 'org-mode-hook
          (lambda () (local-unset-key (kbd "C-,"))))

;; org-mobile
(setq org-mobile-directory "/root/Dropbox/MobileOrg")
(setq org-directory "/root/Dropbox/Org")
(setq org-agenda-files (list "/root/Dropbox/Org/notes.org"))
(setq org-mobile-files (list "/root/Dropbox/Org/notes.org"))
(setq org-mobile-inbox-for-pull "/root/Dropbox/Org/inbox.org")
(setq org-default-notes-file "/root/Dropbox/Org/notes.org")

;; org-pomodoro
(add-hook 'org-pomodoro-started-hook
          (lambda ()
            (setq-default header-line-format
                          '("" org-pomodoro-mode-line org-mode-line-string))
            (delete 'org-mode-line-string global-mode-string)
            (delete 'org-pomodoro-mode-line global-mode-string)))

(add-hook 'org-pomodoro-finished-hook
          (lambda () (notifications-notify :title "Pomodoro" :body "Time is up")))

;;; code
(add-hook 'c-mode-common-hook
          (lambda () (c-toggle-hungry-state 1)))
(add-hook 'c-mode-common-hook
          (lambda () (c-set-offset 'case-label '+)))

;; sh
(defun executable-interpret-on-region (command)
  "Run `executable-interpret' with region text as COMMAND."
  (interactive (list (read-string "Run Script: "
                                  (buffer-substring (mark) (point)))))
  (executable-interpret command))
(add-hook 'sh-mode-hook
          (lambda () (define-key sh-mode-map (kbd "C-c C-x")
                  'executable-interpret-on-region)))

(provide 'init-local)
;;; init-local.el ends here
