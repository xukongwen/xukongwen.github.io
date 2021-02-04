;;一些基础菜单和视觉配置
;;关闭菜单栏
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-fringe-mode 10)
(set-face-attribute 'default nil :font "KKong" :height 230)
;;关闭tooltip
(tooltip-mode -1)
;;关闭开始欢迎页面
(setq inhibit-startup-screen t)
;;视觉显示错误
;;(setq visible-bell t)
;;使用某个theme
(load-theme 'tao-yin t)
;;去掉边上难看的换行符号
(set-fringe-mode 0)
;;自动补全的c-f模式
;;(ido-mode 1)
;;ese-key
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(set-display-table-slot standard-display-table 'wrap ?\ )

;;关闭恼人的自动备份，否则git基本没法用
(setq create-lockfiles nil)
(setq make-backup-files nil)
(setq backup-directory-alist (quote (("." . "~/.backups"))))

(setq-default fringe-indicator-alist (assq-delete-all 'truncation fringe-indicator-alist))


;;开机自动启动某个文件
(find-file "~/github/write/novel/greentunnel.md")
;;========快捷键设置=========

;;把f2绑定成打开设置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(global-set-key (kbd "<f2>") 'open-init-file)


;;插件和插件服务器设置==========
(require 'package)
;;(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                        ;; ("melpa" . "http://elpa.emacs-china.org/melpa/")
			;; ("org" . "https://orgmode.org/elpa/")))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))


(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;;==========配置各种包==========

;;禅宗写作模式，并配置f3是快捷键
;;(use-package writeroom-mode)

(use-package writeroom-mode
  :ensure t
  :hook (emacs-startup . global-writeroom-mode)
  :config
  (setq writeroom-width 90
        writeroom-bottom-divider-width 0
        writeroom-fringes-outside-margins t
        writeroom-fullscreen-effect t
        writeroom-major-modes '( markdown-mode org-mode)
        writeroom-maximize-window t
        writeroom-mode-line nil
        writeroom-mode-line-toggle-position 'mode-line-format))

;;打开全局，同时在MD模式下开启
;;(global-writeroom-mode 1)
;;这个hook的方法未来学习学习
;;(add-hook 'markdown-mode-hook (lambda() (writeroom-mode)))

(defun zen()
  (interactive)
  (writeroom-mode))

(global-set-key (kbd "<f3>") 'zen)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(org-bullets ivy deft magit neotree zenburn-theme markdown-mode org doom-themes all-the-icons-dired all-the-icons-gnus all-the-icons-ibuffer all-the-icons-ivy all-the-icons-ivy-rich doom-modeline airline-themes writeroom-mode use-package pyim moe-theme helm-smex gruvbox-theme company-posframe cnfonts)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; MD
(use-package markdown-mode)

;; 树形file
(use-package neotree)
(global-set-key [f8] 'neotree-toggle)

;;安装这个之前要先把all icon的font给安装了
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 10)))

;;git神器
(use-package magit)

;;笔记本管理
(use-package deft)
(setq deft-extension "md")
(setq deft-text-mode 'markdown-mode)
(setq deft-directory "~/github/write/notes")
(setq deft-use-filename-as-title t)

;;ivy

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :hook (after-init . ivy-mode))

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)


;;========================= org mode===================

(use-package org)
(setq org-ellipsis " ▼ ")

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("☰" "☷" "☯" "☭)))







