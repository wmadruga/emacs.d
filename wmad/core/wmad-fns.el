;; wmad-fns.el --- Core configuration: My functions
;; -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun toggle-doom-alike-terminal ()
  "Drop down a terminal window like in good old Doom days.  vterm is configured to open on a side-window positioned at the top."
  (interactive)
  (if (eq nil (get-buffer "vterm"))
      (vterm)
    (window-toggle-side-windows))
  )

(defun wmad/identify-dependencies (pkg)
  "Identify files dependent of PKG."
  (require 'loadhist)
  (file-dependents (feature-file pkg)))

(defun wmad/load-private-scripts ()
  "Load private scripts located in elisp folder."
  (load (concat user-emacs-directory "elisp/private.el"))
  (load (concat user-emacs-directory "elisp/proxy.el"))
  ;; (load (concat user-emacs-directory "elisp/custom.el"))
  )

(defun wmad/server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server."
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(defun wmad/duplicate-line ()
  "Duplicates line on point."
  (interactive)
   (let* ((cursor-column (current-column)))
    (move-beginning-of-line 1)
    (kill-line) (yank) (newline) (yank)
    (move-to-column cursor-column)))

(defun wmad/transpose-windows ()
  "Transpose two windows.  If more or less than two windows are visible, error."
  (interactive)
  (unless (= 2 (count-windows))
    (error "Can only transpose 2 windows.  No less, no more"))
  (let* ((windows (window-list))
         (w1 (car windows))
         (w2 (nth 1 windows))
         (w1b (window-buffer w1))
         (w2b (window-buffer w2)))
    (set-window-buffer w1 w2b)
    (set-window-buffer w2 w1b)))

(defun wmad/open-bookmarks ()
  "Open my bookmarks file."
  (interactive)
  (wmad/open-brain "bookmarks.org"))

(defun wmad/open-init-file ()
  "Open the init file."
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun wmad/open-brain (file)
  "Open FILE from 2nd-brain."
  (interactive)
  (let* ((2nd-brain-path "~/src/2nd_brain/"))
    (find-file (concat 2nd-brain-path file))))

(defun wmad/open-journal ()
  "Open the journal file."
  (interactive)
  (wmad/open-brain "journal.org"))

(defun wmad/open-todo ()
  "Open the TODO file."
  (interactive)
  (wmad/open-brain "todo.org"))

(provide 'wmad-fns)
;;; wmad-fns.el ends here
