(defvar my_c++_head
(setq myHead "#ifndef jouke__name_
#define jouke_name_

using namespace std;

/*! -------------------------------------------------------------
 * brief   _name_ class
 * \\details
 * \\author  Jouke Hijlkema (jouke.hijlkema@onera.fr)
 * \\date   _date_
 * \\version 1.0
 * -------------------------------------------------------------*/

class _name_ {
public:
  _name_();
 ~_name_();
protected:
private:
};
#endif
"))

(defvar my_c++_class
(setq myClass " #include \"_name_.hpp\"

/* ==============================================================
 * Description : _name_ class
 * initial version : 1.0
 * Author : hylkema (jouke.hijlkema@onera.fr)
 * date   : _date_
 * ============================================================== */

_name_::_name_() {
}

_name_::~_name_() {
}"))

(defun my_c++_new (name)
   "create a new file named name"
   (interactive "BFile name :")     ; ask for a buffer name
   (my_c++_template name ".hpp"  my_c++_head)
   (my_c++_template name ".cpp" my_c++_class))

(defun my_c++_template (name ext tmp)
   (switch-to-buffer-other-window (concat name ext))
   (erase-buffer)
   (setq txt (replace-regexp-in-string "_name_" name tmp))
   (setq txt (replace-regexp-in-string "_date_" (current-time-string) txt))
   (insert txt))

(defun my_c++_sep1 ()
  (insert "/*! -------------------------------------------------------------\n")
  (insert " * -------------------------------------------------------------*/\n")
  (forward-line -1))

(defun my_c++_classname ()
  (interactive)
  (save-excursion
    (call-interactively 'move-end-of-line)
    (search-backward-regexp "\\(^\\w+\\)\\(\\W+\\)\\(\\w+\\)\\(::\\)\\(\\w+\\)")
    (let ((ret (match-string 3)))
      (message ret)
      ret)))  
