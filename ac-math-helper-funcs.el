;; (require 'latex) 
;; (LaTeX-math-default)

(defun ac-latex-display-math-default ()
  "Prints in a new buffer the math symbols defined in `LaTeX-math-default'.
This are the symbols used in Auctex math menu."
  (interactive)
  (let ((buff (get-buffer-create "math-default")))
    (pop-to-buffer buff)
    (erase-buffer)
    (mapcar '(lambda (el)
               (let ((code (nth 3 el))
                     (group (if (listp (nth 2 el))
                                (nth 2 el)
                              (list (nth 2 el)))))
                 (when code
                   (insert (format "%s\t%s\t%c\t%X\n"
                                   (mapconcat 'identity group "/")
                                   (concat "\\" (nth 1 el))
                                   code
                                   code))))
               )
            LaTeX-math-default)
    (org-table-convert-region (point-min) (point-max))
    (goto-char 2)
    (org-table-sort-lines nil ?a)
    ))

(defun ac-latex-make-default-alist ()
  "nicely formated list of symbolds from `LaTeX-math-default'"
  (interactive)
  (let ((buff (get-buffer-create "math-default")))
    (pop-to-buffer buff)
    (erase-buffer)
    (insert "(setq ac-latex-math-default-alist '(\n")
    (mapcar '(lambda (el)
               (let ((code (nth 3 el))
                     (group (if (listp (nth 2 el))
                                (nth 2 el)
                              (list (nth 2 el))))
                     (name (nth 1 el)))
                 (when (stringp name)
                   (if code
                       (insert (format "(%S\t%S\t#X%X)\n"
                                       (mapconcat 'identity group "/")
                                       (concat "\\" name)
                                       code
                                       code))
                     (insert (format "(%S\t%S)\n"
                                     (mapconcat 'identity group "/")
                                     (concat "\\" name)
                                     )))
                 )))
            LaTeX-math-default)
    (insert "))")
    ))

(defun ac-latex-make-unicode-math ()
  (interactive)
  (let ((buff (get-buffer-create "unicode-math")))
    (pop-to-buffer buff)
    (erase-buffer)
    (insert "(setq ac-latex-unicode-math-alist '(\n")
    (mapcar '(lambda (el)
               (let ((code (string-to-number (nth 0 el) 16))
                     (group (substring-no-properties (nth 2 el) 5)))
                 (insert (format "(%S\t%S\t#X%X)\n"
                                 group
                                 (nth 1 el)
                                 code))))
            unicode-math-table)
    )
  (insert "))")
  )

;; (setq math-symbols
;;       (delete-dups (mapcar '(lambda (el)
;;                               (nth 1 el))
;;                            (append ac-latex-math-default-alist
;;                                    ac-latex-math-extended-alist))))
;; (length ac-latex-commands)
;; (setq ac-latex-commands-temp
;;       (delq nil (mapcar '(lambda (el)
;;                            (unless (member (concat "\\" el)
;;                                            math-symbols)
;;                              el
;;                            ))
;;                         ac-latex-commands)))
