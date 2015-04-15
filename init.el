;; -*- coding: utf-8 -*-

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))

(setq *macbook-pro-support-enabled* t)

(setq *is-a-mac* (eq system-type 'darwin))
(setq *is-carbon-emacs* (and *is-a-mac* (eq window-system 'mac)))
(setq *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))
(setq *win32* (eq system-type 'windows-nt) )
(setq *cygwin* (eq system-type 'cygwin) )
(setq *linux* (or (eq system-type 'gnu/linux) (eq system-type 'linux)) )
(setq *unix* (or *linux* (eq system-type 'usg-unix-v) (eq system-type 'berkeley-unix)) )
(setq *linux-x* (and window-system *linux*) )
(setq *xemacs* (featurep 'xemacs) )
(setq *emacs24* (and (not *xemacs*) (or (>= emacs-major-version 24))) )




;;init-elpa

;; gnu - http://elpa.gnu.org/packages/
;; marmalade - http://marmalade-repo.org/packages/
;; melpa - http://melpa.milkbox.net/packages/

(require 'package)

(add-to-list 'package-archives
'("melpa" . "http://melpa.org/packages/") t)


(package-initialize)

(defun require-package (package &optional min-version no-refresh)
"Ask elpa to install given PACKAGE."
(if (package-installed-p package min-version)
t
(if (or (assoc package package-archive-contents) no-refresh)
(package-install package)
(progn
(package-refresh-contents)
(require-package package min-version t)))))

(require-package 'color-theme)
(require-package 'color-theme-sanityinc-solarized)
(require-package 'color-theme-sanityinc-tomorrow)
(require-package 'powerline)
(require-package 'nyan-mode)
(require-package 'ace-jump-mode)
(require-package 'expand-region)
(require-package 'haskell-mode)
(require-package 'magit)
(require-package 'git-commit-mode)
(require-package 'gitignore-mode)
(require-package 'gitconfig-mode)
(require-package 'wgrep)
(require-package 'lua-mode)
(require-package 'paredit)
(require-package 'erlang)
(require-package 'haml-mode)
(require-package 'smex)
(require-package 'helm)
(require-package 'helm-gtags)
(require-package 'smex)
(require-package 'markdown-mode)
(require-package 'dired+)
(require-package 'org-fstree)
(require-package 'scratch)
(require-package 'exec-path-from-shell)
(require-package 'regex-tool)
(require-package 'csharp-mode)
(require-package 'cmake-mode)
(require-package 'session)
(require-package 'idomenu)
(require-package 'ggtags)
(require-package 'maxframe)
(require-package 'cpputils-cmake)
(require-package 'dropdown-list)
(require-package 'yasnippet)
(require-package 'multi-term)
(require-package 'json-mode)
(require-package 'fancy-narrow)
(require-package 'sr-speedbar)
(require-package 'string-edit)
(require-package 'smartparens)
(require-package 'auto-complete)
(require-package 'ac-etags)
(require-package 'projectile)
(require-package 'helm-projectile)
(require-package 'project-explorer)
(require-package 'js2-mode)
(require-package 'web-mode)
(require-package 'ac-js2)
(require-package 'groovy-mode)
(require-package 'neotree)
(require-package 'yaml-mode)

;; init-xterm

(defun fix-up-xterm-control-arrows ()
(let ((map (if (boundp 'input-decode-map)
input-decode-map
function-key-map)))
(define-key map "\e[1;5A" [C-up])
(define-key map "\e[1;5B" [C-down])
(define-key map "\e[1;5C" [C-right])
(define-key map "\e[1;5D" [C-left])
(define-key map "\e[5A" [C-up])
(define-key map "\e[5B" [C-down])
(define-key map "\e[5C" [C-right])
(define-key map "\e[5D" [C-left])))

(add-hook 'after-make-console-frame-hooks
(lambda ()
(when (< emacs-major-version 23)
(fix-up-xterm-control-arrows))
(xterm-mouse-mode 1) ; Mouse in a terminal (Use shift to paste with middle button)
;; Enable wheelmouse support by default
(cond (window-system
(mwheel-install)))
))


;; init-osx key

(when *is-a-mac*
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'none)
(setq default-input-method "MacOSX")
;; Make mouse wheel / trackpad scrolling less jerky
(setq mouse-wheel-scroll-amount '(0.001))
(when *is-cocoa-emacs*
;; Woohoo!!
(global-set-key (kbd "M-`") 'ns-next-frame)
(global-set-key (kbd "M-h") 'ns-do-hide-emacs)
(global-set-key (kbd "M-ˍ") 'ns-do-hide-others) ;; what describe-key reports
(global-set-key (kbd "M-c") 'ns-copy-including-secondary)
(global-set-key (kbd "M-v") 'ns-paste-secondary)))


;; init-gui-frame

(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)
(setq inhibit-startup-echo-area-message t)

(setq indicate-empty-lines t)

(if window-system
    (progn
      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
      (set-fringe-mode 0)
      (setq visible-bell nil)
      (require 'nyan-mode)       ;; nyan-mode
      (nyan-mode t))
  )



;; init-ido

(ido-mode t)

(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point nil)
(setq ido-auto-merge-work-directories-length nil)
(setq ido-use-virtual-buffers t)

;; Allow the same buffer to be open in different frames
(setq ido-default-buffer-method 'selected-window)

;; init-maxframe
(require 'maxframe)
(add-hook 'window-setup-hook 'maximize-frame t)

;; init-smex
(require 'smex)
(smex-initialize)
(autoload 'smex "smex" nil t)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; init-helm

(setq helm-completing-read-handlers-alist
'((describe-function . ido)
(describe-variable . ido)
(debug-on-entry . helm-completing-read-symbols)
(find-function . helm-completing-read-symbols)
(find-tag . helm-completing-read-with-cands-in-buffer)
(ffap-alternate-file . nil)
(tmm-menubar . nil)
(dired-do-copy . nil)
(dired-do-rename . nil)
(dired-create-directory . nil)
(find-file . ido)
(copy-file-and-rename-buffer . nil)
(rename-file-and-buffer . nil)
(w3m-goto-url . nil)
(ido-find-file . nil)
(ido-edit-input . nil)
(mml-attach-file . ido)
(read-file-name . nil)
(yas/compile-directory . ido)
(execute-extended-command . ido)
(minibuffer-completion-help . nil)
(minibuffer-complete . nil)
(c-set-offset . nil)
(wg-load . ido)
(rgrep . nil)
(read-directory-name . ido)
))


;; {{helm-gtags
;; customize
(autoload 'helm-gtags-mode "helm-gtags" nil t)
(setq helm-c-gtags-path-style 'relative)
(setq helm-c-gtags-ignore-case t)
(setq helm-c-gtags-read-only t)
(add-hook 'c-mode-hook (lambda () (helm-gtags-mode)))
(add-hook 'c++-mode-hook (lambda () (helm-gtags-mode)))
;; }}


;; key bindings
(add-hook 'helm-gtags-mode-hook
'(lambda ()
(local-set-key (kbd "M-t") 'helm-gtags-find-tag)
(local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
(local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
(local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
(local-set-key (kbd "C-c C-f") 'helm-gtags-pop-stack)))
;; ==end

(if *emacs24*
(progn
(autoload 'helm-c-yas-complete "helm-c-yasnippet" nil t)
(global-set-key (kbd "C-x C-o") 'helm-find-files)
(global-set-key (kbd "C-c f") 'helm-for-files)
(global-set-key (kbd "C-c y") 'helm-c-yas-complete)
(global-set-key (kbd "C-c i") 'helm-imenu)
)
(global-set-key (kbd "C-x C-o") 'ffap)
)

(autoload 'helm-swoop "helm-swoop" nil t)
(autoload 'helm-back-to-last-point "helm-swoop" nil t)

;; When doing isearch, hand the word over to helm-swoop
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)


(autoload 'helm-ls-git-ls "helm-ls-git" nil t)
(autoload 'helm-browse-project "helm-ls-git" nil t)


;; init-sessions

(setq desktop-path '("~/.emacs.d"))
(setq desktop-save 'if-exists)
(desktop-save-mode 1)
(defadvice desktop-read (around trace-desktop-errors)
(let ((debug-on-error t))
ad-do-it))


;;----------------------------------------------------------------------------
;; Restore histories and registers after saving
;;----------------------------------------------------------------------------
(setq session-save-file (expand-file-name "~/.emacs.d/.session"))
(add-hook 'after-init-hook 'session-initialize)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
(append '((extended-command-history . 30)
(file-name-history . 100)
(ido-last-directory-list . 100)
(ido-work-directory-list . 100)
(ido-work-file-list . 100)
(grep-history . 30)
(compile-history . 30)
(minibuffer-history . 50)
(query-replace-history . 60)
(read-expression-history . 60)
(regexp-history . 60)
(regexp-search-ring . 20)
(search-ring . 20)
(comint-input-ring . 50)
(shell-command-history . 50)
(evil-ex .100)
desktop-missing-file-warning
tags-file-name
register-alist)))


;; init-linum
(global-linum-mode 0)

;; init-ace

(autoload
'ace-jump-mode
"ace-jump-mode"
"Emacs quick move minor mode"
t)

(define-key global-map (kbd "C-;") 'ace-jump-mode)

;; expand-region
(require 'expand-region)
(global-set-key (kbd "C-2") 'er/expand-region)

;; init-sr-speedbar

(autoload 'sr-speedbar-toggle "sr-speedbar")

;; sr-speedbar config
(setq sr-speedbar-right-side nil)
(setq sr-speedbar-skip-other-window-p t)
;; no auto-refresh
(setq sr-speedbar-auto-refresh nil)

(setq sr-speedbar-width-console 30)
(setq sr-speedbar-width-x 30)

;; regular speedbar config
(setq speedbar-show-unknown-files t)
(setq speedbar-verbosity-level 0)
;(setq speedbar-use-images nil)

(defun speedbar-edit-line-and-switch-to-window ()
(interactive)
(speedbar-edit-line)
(other-window 1))

;; (global-set-key (kbd "C-m") 'sr-speedbar-toggle)

;; color
(require 'color-theme)

;; powerline
;; (require 'powerline)
;; (powerline-center-theme)
;; (powerline-raw mode-line-mule-info nil 'l)

;; mode-line

;;smartparens
(require 'smartparens-config)
(smartparens-global-mode 1)

;;yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;;auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(ac-set-trigger-key "M-/")

;; (set-default 'ac-sources
;; '(ac-source-imenu
;; ac-source-dictionary
;; ac-source-words-in-buffer
;; ac-source-words-in-same-mode-buffers
;; ac-source-words-in-all-buffer))

;;ac-etags
'(ac-etags-requires 1)
(eval-after-load "etags"
'(progn
(ac-etags-setup)))

(add-hook 'c-mode-common-hook 'ac-etags-ac-setup)
(add-hook 'ruby-mode-common-hook 'ac-etags-ac-setup)

;;python


;;js2-mode
(add-hook 'js2-mode-hook 'ac-js2-mode)

;; local

;;helm
(global-set-key (kbd "C-o") 'helm-imenu)


;;projectile
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)

;;project-explorer
(global-set-key (kbd "M-m") 'project-explorer-open)


;;switch buffer
(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<right>") 'next-buffer)

;;NavigatingParentheses
(global-set-key (kbd "M-[") 'backward-sexp)
(global-set-key (kbd "M-]") 'forward-sexp)

;;scroll
(defun window-half-height ()
     (max 1 (/ (1- (window-height (selected-window))) 2)))
  
   (defun scroll-up-half ()
     (interactive)
     (scroll-up (window-half-height)))
  
   (defun scroll-down-half ()        
     (interactive)                   
     (scroll-down (window-half-height)))
  
(global-set-key (kbd "C-v") 'scroll-up-half)
(global-set-key (kbd "M-v") 'scroll-down-half)


;;other window
(global-set-key (kbd "M-o") 'other-window)

;;tags
(global-set-key (kbd "M-.") 'helm-etags-select)

;;go-back
(global-set-key (kbd "C-M-<left>") 'pop-global-mark)

;;hs-mode
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'ess-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'sh-mode-hook 'hs-minor-mode)
(add-hook 'lua-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(global-set-key (kbd "C--") 'hs-hide-block)
(global-set-key (kbd "C-_") 'hs-hide-all)
(global-set-key (kbd "C-=") 'hs-show-block)
(global-set-key (kbd "C-+") 'hs-show-all)

;;no backup
(setq make-backup-files nil)

;; remove ^M
(defun remove-dos-eol ()
"Do not show ^M in files containing mixed UNIX and DOS line endings."
(interactive)
(setq buffer-display-table (make-display-table))
(aset buffer-display-table ?\^M []))

;;alias
(fset 'yes-or-no-p 'y-or-n-p)
(fset 'dtw 'delete-trailing-whitespace)

;;smart-beginning-of-line
(defun smart-beginning-of-line ()
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
      (beginning-of-line))))

(global-set-key (kbd "C-a") 'smart-beginning-of-line)



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#52676f" "#c60007" "#728a05" "#a57705" "#2075c7" "#c61b6e" "#259185" "#fcf4dc"))
 '(column-number-mode t)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "756597b162f1be60a12dbd52bab71d40d6a2845a3e3c2584c6573ee9c332a66e" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(fci-rule-color "#e9e2cb")
 '(session-use-package t nil (session))
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#c60007")
     (40 . "#bd3612")
     (60 . "#a57705")
     (80 . "#728a05")
     (100 . "#259185")
     (120 . "#2075c7")
     (140 . "#c61b6e")
     (160 . "#5859b7")
     (180 . "#c60007")
     (200 . "#bd3612")
     (220 . "#a57705")
     (240 . "#728a05")
     (260 . "#259185")
     (280 . "#2075c7")
     (300 . "#c61b6e")
     (320 . "#5859b7")
     (340 . "#c60007")
     (360 . "#bd3612"))))
 '(vc-annotate-very-old-color nil))
