;;; competitive-programming-snippets.el --- Competitive programming snippets for yasnippet.

(require 'yasnippet)

(defconst competitive-programming-snippets-dir
  (expand-file-name
    "snippets"
    (file-name-directory
      (cond
        (load-in-progress load-file-name)
        ((and (boundp 'byte-compile-current-file) byte-compile-current-file)
          byte-compile-current-file)
        (:else (buffer-file-name))))))

(defun competitive-programming-snippets-initialize ()
  (add-to-list 'yas-snippet-dirs 'competitive-programming-snippets-dir t)
  (yas-load-directory competitive-programming-snippets-dir t))

(eval-after-load 'yasnippet
  '(competitive-programming-snippets-initialize))

(provide 'competitive-programming-snippets)

;;; competitive-programming-snippets.el ends here
