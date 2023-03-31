;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Ken Kohlmann"
      user-mail-address "ken@cttm.io")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-monokai-pro)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
;; (setq org-directory "~/org-roam/")
(setq org-directory "~/org-roam/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Stuff below is stuff ken added
;;
;; this adds a timestamp when TODO item state
;; is changed
;; (setq org-log-done 'time)

;; this is for mermaid support
(setq ob-mermaid-cli-path "/opt/homebrew/bin/mmdc")

(use-package! org-roam :custom (org-roam-directory "~/org-roam") :config (org-roam-setup))

(defun buffer/insert-filename ()
  "Insert file name of current buffer at current point"
  (interactive)
  (insert (buffer-file-name (current-buffer))))

(use-package! zig-mode
  :hook ((zig-mode . lsp-deferred))
  :custom (zig-format-on-save nil)
  :config
  (after! lsp-mode
    (add-to-list 'lsp-language-id-configuration '(zig-mode . "zig"))
    (lsp-register-client
      (make-lsp-client
        :new-connection (lsp-stdio-connection "/Users/kenk/cli_apps/zls")
        :major-modes '(zig-mode)
        :server-id 'zls))))

(pythonic-activate "~/penv")
;; beautify org mode stuff
;; (custom-theme-set-faces!
;;    'user
;;    '(org-code :family "Menlo")
;;    '(org-block :family "Menlo")
;;    '(org-default :family "Arial")
;;    ;; '(org-roam-title :family "Arial")
;; )
;; end beautify org mode

;; vlang
(require 'v-mode)
;; (define-key v-mode-map (kbd "M-z") 'v-menu)
;; (define-key v-mode-map (kbd "<f6>")  'v-menu)
;; (define-key v-mode-map (kbd "C-c C-f") 'v-format-buffer)
;;end vlang

(setq org-babel-python-command "/Users/kenk/penv/bin/python")
(custom-theme-set-faces! 'doom-monokai-pro
    '(line-number :foreground "dim gray"))
;; everything here is for reducing noise while recording videos
;; we should make this a function at some point
(setq lsp-ui-doc-enable nil)
(setq lsp-headerline-breadcrumb-enable nil)
(setq lsp-ui-sideline-enable nil)
(setq lsp-signature-render-documentation nil)
(setq lsp-signature-auto-activate nil)
(setq lsp-eldoc-enable-hover nil)
(setq lsp-completion-provider :none)
(setq lsp-completion-show-detail nil)
(setq lsp-completion-show-kind nil)
(setq lsp-ui-doc-show-with-cursor nil)
(setq lsp-ui-doc-show-with-mouse nil)
(setq lsp-ui-sideline-show-hover nil)
(setq lsp-modeline-code-actions-enable nil)
(setq lsp-completion-enable nil)

(define-key org-mode-map (kbd "s-j") 'org-insert-todo-heading) ; s is for hyper

;; if you want to disable all modelines:
(setq-default mode-line-format nil)
(setq mode-line-format nil)
