(defun dir-name (path)
  (file-relative-name path (expand-file-name (concat (file-name-directory path) ".."))))

(defun find-base-plus-suffix (file-name)

  (defun travel (dir)
    (if (or (string= (dir-name dir) "src/") (string= (dir-name dir) "include/"))
        dir
      (let ((parent (expand-file-name (concat dir "../"))))
        (if (string= parent "/")
            nil
          (travel parent)))))

  (let ((dir (file-name-directory file-name)))
    (travel dir)))

(defun complete-other-file-base (other-file-base)
  (if (not (file-exists-p (file-name-directory other-file-base)))
      nil
    (let ((completion (file-name-completion (file-name-nondirectory other-file-base) (file-name-directory other-file-base))))
      (cond ((null completion) nil)
            ((booleanp completion) other-file-base)
            (t (concat (file-name-directory other-file-base) completion))))))

(defun find-other-file-simple (this-file-name base-plus-suffix)
  (let ((other (cond ((string= (dir-name base-plus-suffix) "include/") "src/")
                     ((string= (dir-name base-plus-suffix) "src/") "include/"))))
    (complete-other-file-base (concat (expand-file-name (concat base-plus-suffix "../" other))
                                      (file-name-sans-extension (substring this-file-name (length base-plus-suffix)))))))

(defun find-other-file-complex (this-file-name base-plus-suffix)
  (let ((parent-dir (expand-file-name (concat base-plus-suffix "../"))))
    (let ((parent-name (dir-name parent-dir))
          (local-path (substring this-file-name (length base-plus-suffix))))
      (complete-other-file-base (file-name-sans-extension (concat parent-dir
                                                                  (cond ((string= (dir-name base-plus-suffix) "src/") (concat "include/" parent-name local-path))
                                                                        ((string= (dir-name base-plus-suffix) "include/") (concat "src/" (substring local-path (length parent-name)))))))))))
(defun find-other-file (this-file-name)
  (let ((base-plus-suffix (find-base-plus-suffix this-file-name)))
    (if (null base-plus-suffix)
        nil
      (let ((other-file-simple (find-other-file-simple this-file-name base-plus-suffix)))
        (if (not (null other-file-simple))
            other-file-simple
          (find-other-file-complex this-file-name base-plus-suffix))))))

(defun switch-include-source ()
  (interactive)
  (if (null (buffer-file-name))
      (message "File not saved!")
    (let ((other-file (find-other-file (buffer-file-name))))
      (if (null other-file)
          (message "Could not find include/source file corresponding to this buffer.")
        (find-file other-file)))))
