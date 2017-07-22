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
(define-key global-map (kbd "C-, c") 'avy-goto-char)
(define-key global-map (kbd "C-, l") 'avy-goto-line)
(define-key global-map (kbd "C-, r") 'rename-buffer)
(define-key global-map (kbd "C-, e") 'eshell)
(define-key global-map (kbd "C-, a") 'ansi-term)
(define-key global-map (kbd "C-, t") 'google-translate-smooth-translate)
(define-key global-map (kbd "C-, s") 'swiper)
(define-key global-map (kbd "C-, g") 'counsel-git-grep)
(define-key global-map (kbd "C-, i") 'counsel-imenu)
(define-key global-map (kbd "C-, p") 'org-pomodoro)
(global-unset-key (kbd "C-z"))

;;; ui
(setq desktop-save nil)
(put 'dired-find-alternate-file 'disabled nil)

;; font
(set-face-attribute 'default nil :font "Noto Mono")
(set-fontset-font t 'unicode (font-spec :family "WenQuanYi Zen Hei Mono"))
(setq face-font-rescale-alist '(("WenQuanYi Zen Hei Mono" . 1.2)))

;;; alert
(require-package 'alert)
(setq alert-default-style 'notifications)

;;; recentf
(defun recentd-track-opened-file ()
  "Insert the name of the directory just opened into the recent list."
  (and (derived-mode-p 'dired-mode) default-directory
       (recentf-add-file default-directory))
  ;; Must return nil because it is run from `write-file-functions'.
  nil)

(defun recentd-track-closed-file ()
  "Update the recent list when a dired buffer is killed.
That is, remove a non kept dired from the recent list."
  (and (derived-mode-p 'dired-mode) default-directory
       (recentf-remove-if-non-kept default-directory)))

(add-hook 'dired-after-readin-hook 'recentd-track-opened-file)
(add-hook 'kill-buffer-hook 'recentd-track-closed-file)

;;; Prodigy
(require-package 'prodigy)
(prodigy-define-service
  :name "docker"
  :command "systemctl"
  :args '("--wait" "start" "docker")
  :tags '(systemd))
(prodigy-define-service
  :name "Wifi"
  :command "systemctl"
  :args '("--wait" "start" "netctl-auto@wlp2s0")
  :tags '(systemd))
(prodigy-define-service
  :name "ss-btcc-prod"
  :command "systemctl"
  :args '("--wait" "start" "shadowsocks-libev@btcc-prod")
  :tags '(btcc-prod))
(prodigy-define-service
  :name "vpn-btcc-green"
  :command "systemctl"
  :args '("--wait" "start" "openvpn-client@btcc-green-zeyu2")
  :tags '(btcc-prod))
(prodigy-define-service
  :name "cn2t-64-redir"
  :command "systemctl"
  :args '("--wait" "start" "shadowsocks-auto-redir@cn2t-64-redir")
  :tags '(shadowsocks))
(prodigy-define-service
  :name "sg-189-redir"
  :command "systemctl"
  :args '("--wait" "start" "shadowsocks-auto-redir@sg-189-redir")
  :tags '(shadowsocks))
(prodigy-define-service
  :name "niobium-frontend"
  :command "docker-compose"
  :args '("up")
  :cwd "/root/git/BTCChina/niobium-frontend"
  :tags '(docker))

;;; elfeed
(require-package 'elfeed)
(define-key global-map (kbd "C-x w") 'elfeed)
(setq elfeed-feeds
      '("http://feeds.feedburner.com/ruanyifeng"))

;;; google
;; translate
(require-package 'google-translate)
(setq google-translate-translation-directions-alist
      '(("en" . "zh-CN") ("zh-CN" . "en")))

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
(defun org-pomodoro-running ()
  "Pomodoro start hook."
  (setq-default header-line-format
                '("" org-pomodoro-mode-line org-mode-line-string))
  (delete 'org-mode-line-string global-mode-string)
  (delete 'org-pomodoro-mode-line global-mode-string))
(defun org-pomodoro-stopped ()
  "Pomodoro end hook."
  (setq-default header-line-format
                '(""
                  (:eval (propertize "NOT IN POMODORO" 'face
                                     (list :background "red"
                                           :foreground "white"
                                           ))))))
(add-hook 'org-pomodoro-started-hook 'org-pomodoro-running)
(add-hook 'org-pomodoro-finished-hook 'org-pomodoro-stopped)
(add-hook 'org-pomodoro-killed-hook 'org-pomodoro-stopped)
(org-pomodoro-stopped)

;;; code
(add-hook 'c-mode-common-hook
          (lambda () (c-toggle-hungry-state 1)))

(require-package 'yasnippet)
(require-package 'react-snippets)
(yas-global-mode 1)

;; web-mode
(require-package 'web-mode)
(add-to-list 'auto-mode-alist '("\\.[jt]s[x]?\\'" . web-mode))
(setq web-mode-content-types-alist
      '(("jsx" . "\\.[jt]s[x]?\\'")))
(setq web-mode-markup-indent-offset 2
      web-mode-attr-indent-offset 2
      web-mode-attr-value-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2)
(setq web-mode-enable-auto-quoting nil)
(add-hook 'web-mode-hook 'tern-mode)

;; php
(setq geben-path-mappings
      '(("/root/git/BTCChina/btcchina-docker-compose/btcchina"
         "/var/www/btcchina")))
(add-hook 'php-mode-hook 'php-enable-psr2-coding-style)

;; sh
(defun executable-interpret-on-region (command)
  "Run `executable-interpret' with region text as COMMAND."
  (interactive (list (read-string "Run Script: "
                                  (buffer-substring (mark) (point)))))
  (executable-interpret command))
(add-hook 'sh-mode-hook
          (lambda () (define-key sh-mode-map (kbd "C-c C-x")
                  'executable-interpret-on-region)))

;; js
(setq js2-strict-missing-semi-warning nil)

(provide 'init-local)
;;; init-local.el ends here
