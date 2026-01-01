; -*- lexical-binding: t; -*-
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s seconds with %d garbage collections."
                     (emacs-init-time "%.2f")
                     gcs-done)))
(set 'package-selected-packages
     '(multiple-cursors
       evil-iedit-state
       iedit
       magit
       flycheck-package
       ace-window
       undo-tree
       tsc
       linum-relative
       goto-last-change
       fast-scroll
       glsl-mode
       which-key
       rainbow-delimiters
       restart-emacs
       lorem-ipsum
       treemacs
       neotree
       all-the-icons
       ;; powerline
       ido-completing-read+
       amx
       fancy-battery
       ;; company-box
       lsp-mode
       ;; evil
       evil-mc
       evil-commentary
       evil-collection
       evil-better-visual-line
       evil-leader
       ;; Themes
       ;; gotham-theme
       ;; dracula-theme
       ;; atom-one-dark-theme
       monokai-theme
       monokai-pro-theme
       monokai-alt-theme
       ;; timu-spacegrey-theme
       org-bullets
       org-download
       org-fragtog
       evil-org
       org-modern
       ))
(use-package elcord
  :hook (prog-mode . elcord-mode))
(use-package company
  :bind (:map company-mode-map
	      ("<backtab>" . company-search-mode))
  :hook (('text-mode-hook (lambda ()
			    (setq-local company-backends '(company-wordfreq))
			    (setq-local company-transformers nil))))
  :config
  (global-company-mode t)
  (use-package company-math)
  (use-package company-spell)
  (use-package company-dict)
  (use-package company-org-block)
  (use-package company-wordfreq))
(use-package yaml-mode)
(use-package yaml-ts-mode)
(use-package flycheck-actionlint
  :hook
  (yaml-mode flymake-actionlint-action-load-when-actions-file)
  :hook
  (yaml-ts-mode flymake-actionlint-action-load-when-actions-file))
(use-package rustic
  ;; :mode ("\\.rs\\'" . rustic-mode)
  :hook ((rustic-mode . lsp)
	 (rustic-mode . company-mode)
	 (rustic-mode . eldoc-mode))
  :config
  (use-package cargo-mode
    :mode "cargo.toml\\'")
  (use-package cargo)
  (setq rustic-run-arguments "--release"))
(package-refresh-contents t)
(package-install-selected-packages)
(setq auto-save-file-name-transforms
      `((".*" ,(concat user-emacs-directory "auto-save/") t))) 
(setq backup-directory-alist
      `(("." . ,(expand-file-name
		 (concat user-emacs-directory "backups")))))
;; THEME & FONT
(setq custom-safe-themes t)
(load-theme 'monokai)
;; (set-face-attribute 'default (:family "JetBrains Mono" :foundry "outline" :slant normal :weight regular :height 120 :width normal))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "JetBrains Mono" :foundry "outline" :slant normal :weight regular :height 120 :width normal)))))
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
(add-hook 'prog-mode-hook #'indent-tabs-mode)
					; Startup
;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tab-bar-mode t)
(url-handler-mode 1)
;; (visual-line-mode -1)
;; (setq-default word-wrap t)
(setq auto-save-no-message t)
(setq truncate-partial-width-windows 200)
(setq truncate-lines nil)
(setq truncate-lines t)
(global-set-key (kbd "C-x x w") 'whitespace-mode)
(global-set-key (kbd "C-x x t") 'toggle-truncate-lines)
;; Customize my powerline
(display-time-mode t)
(show-paren-mode t)
(add-hook 'after-init-hook #'fancy-battery-mode)
(setq fancy-battery-show-percentage t)
(when (display-graphic-p)
  (require 'all-the-icons))
;;(require 'powerline
;;(powerline-vim-theme)
;;	 )
(add-hook 'window-size-change-functions
	  #'frame-hide-title-bar-when-maximized)
(use-package enlight
  :config
  (setopt initial-buffer-choice #'enlight)
  (setq tab-bar-new-tab-choice 'enlight-open)
  (setq tab-bar-new-tab-to 'rightmost)
  :custom
  (enlight-content
   (concat
    (propertize "MENU" 'face 'highlight)
    "\n"
    (enlight-menu
     '(("Configuration"
	(".emacs" (find-file "~/.emacs") "e"))
       ("EShell"
	("Open Eshell" (eshell)))
       ("Org Mode"
	("Org-Agenda (current day)" (org-agenda nil "o") "o"))
       ("Dev"
	("Dev folder" (dired "D:/Dev") "d")
	("Dev Game" (dired "D:/Dev/_!GameDev/") "d")
	("Dev Game (Isometric mc)" (dired "D:/Dev/_!GameDev/isometric_engine") "d")
	)
       ("Downloads"
	("Downloads folder" (dired "~/../../Downloads") "a"))
       ("Other"
	("MPV config" (find-file "~/mpv/mpv.conf"))
	("MPV scripts" (dired "~/mpv/scripts"))
	;; ("Projects" project-switch-project "p")
	)
       )))))
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(ido-mode)
(ido-everywhere)
(global-set-key (kbd "C-x d") 'ido-dired)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)
(amx-initialize)
(amx-mode)
(setq ido-enable-flex-matching t)
(add-to-list 'load-path "path/to/which-key.el")
(require 'which-key
	 (which-key-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)
(eval-after-load 'flycheck
  '(flycheck-package-setup))
(use-package evil
  :init
  (setq evil-want-keybinding nil)
  :hook (eshell-mode . turn-off-evil-mode)
  :config
  (evil-collection-init)
  (evil-mode t)
  (define-key evil-motion-state-map ";" 'amx)
  (define-key evil-motion-state-map ":" 'evil-ex)
  (define-key evil-motion-state-map "gb" 'evil-prev-buffer)
  (define-key evil-motion-state-map "gn" 'evil-next-buffer)
  ;; i use "," key as my evil-mc leader keybinding
  ;; this means that doing "," equals to doing "g ."
  ;; (require evil-mc)
  ;; (define-key evil-motion-state-map "S <up>" 'evil-mc-make-cursor-move-prev-line)
  ;; (define-key evil-motion-state-map "S <down>" 'evil-mc-make-cursor-move-next-line)
  ;; (define-key evil-motion-state-map "S q" 'evil-mc-undo-all-cursors)
  ;; (define-key evil-motion-state-map "K" 'evil-next-buffer)
  ;; (define-key evil-motion-state-map "J" 'evil-prev-buffer)
  ;; (when (featurep 'tab-bar)
  ;;   (define-key evil-motion-state-map "L" 'evil-tab-next)
  ;;   (define-key evil-window-map "L" 'evil-tab-next)
  ;;   (define-key evil-motion-state-map "H" 'tab-bar-switch-to-prev-tab)
  ;;   (define-key evil-window-map "H" 'tab-bar-switch-to-prev-tab))
  (use-package evil-mc
    :config
    (global-evil-mc-mode 1)
    (evil-define-key 'visual evil-mc-key-map
      "A" #'evil-mc-make-cursor-in-visual-selection-end
      "I" #'evil-mc-make-cursor-in-visual-selection-beg)))
(use-package aggressive-indent
  :hook (elisp-mode . aggressive-indent-mode))
(global-set-key (kbd "C-/") 'comment-line)
(line-number-mode t)
(column-number-mode t)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)
(size-indication-mode t)
(add-hook 'emacs-lisp-mode-hook #'flycheck-mode)
(add-hook 'emacs-lisp-mode-hook #'company-mode)
(add-hook 'emacs-lisp-mode-hook #'eldoc-mode)
(use-package lorem-ipsum
  :config
  (lorem-ipsum-use-default-bindings)
  (custom-set-variables
   '(warning-suppress-types '((auto-save)))))

(use-package org
  :hook (('org-mode . #'company-mode)
	 ('org-mode . #'org-indent-mode)
	 ('org-mode . #'org-bullets-mode)
	 ('org-mode . #'org-fragtog-mode)
	 ('org-mode . #'org-modern-mode)
	 ('org-mode . #'org-num-mode))
  :config
  (use-package evil-org
    :ensure t
    :after org
    :hook (org-mode . (lambda () evil-org-mode))
    :config
    (require 'evil-org-agenda)
    (evil-org-agenda-set-keys))
  (setq org-agenda-files '("~/org" "G:/My Drive/org" "G:/My Drive/org")))

(add-hook 'before-save-hook (lambda () (org-babel-execute-buffer)) nil t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   ;; (Rust . t)
   (emacs-lisp . t)
   (C . t)
   ))
(setq org-confirm-babel-evaluate nil)
;; (add-hook 'emacs-startup-hook (lambda () (desktop-read)))
(add-hook 'kill-emacs-hook (lambda () (desktop-save-in-desktop-dir "~/.emacs.d/.")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yaml-mode multiple-cursors evil-iedit-state iedit magit flycheck-package ace-window undo-tree tsc linum-relative goto-last-change fast-scroll glsl-mode which-key rainbow-delimiters restart-emacs lorem-ipsum treemacs neotree all-the-icons ido-completing-read+ amx fancy-battery lsp-mode evil-mc evil-commentary evil-collection evil-better-visual-line evil-leader monokai-theme monokai-pro-theme monokai-alt-theme org-bullets org-download org-fragtog evil-org org-modern))
 '(warning-suppress-types '((auto-save))))
