This add-on defines three ac-sources for the *[auto-complete](https://github.com/auto-complete)* package:

 * ac-source-latex-commands		  - input latex commands 
 * ac-source-math-latex		 - input math latex tags  (by default, active only in math environments)

      ![symbols](https://raw.github.com/vitoshka/ac-math/master/img/latex-symbols.png)

 * ac-source-math-unicode - input of unicode symbols (_by default, active everywhere except math environments_)

      ![math](https://raw.github.com/vitoshka/ac-math/master/img/unicode-math.png)

Start math completion by typing the prefix "\" key. Select the completion type RET (`ac-complete`). Completion on TAB (`ac-expand`) is not working that well as yet.

Depending on the context the unicode symbol or latex \tag will be inserted.

## Activation ##

You must have  *[auto-complete](https://github.com/auto-complete)* package installed.

Ac-math is available thorough [MELPA](http://melpa.milkbox.net/) repository. You can also download [ac-math.el](https://raw.github.com/vitoshka/ac-math/master/ac-math.el) directly
and put it into your load-path directory.

This is an example of how to activate the 'ac-math' in latex-mode:

```lisp

(require 'ac-math)

(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources)))

(add-hook 'latex-mode-hook 'ac-latex-mode-setup)
```

If you are using 'flyspell' you might want to activate the [workaround](http://www.emacswiki.org/emacs/AutoComplete#toc6):
```lisp
(ac-flyspell-workaround)
```

## Unicode Input ##

To use unicode in full force with LaTeX you will need
[XeTeX](http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&item_id=xetex) bundle.

By default unicode input (`ac-source-math-unicode`) is not activated in latex math environments. To activate, do
 
```lisp
(setq ac-math-unicode-in-math-p t)
```

You can always call UNDO to insert LaTeX command instead of Unicode character. For instance `\alp RET` inserts the character, then undo reinserts `\alpha`. Hence, you might consider removing `ac-source-math-latex` altogether from the list of `ac-sources` to increase the completion speed:
```lisp
(defun ac-latex-mode-setup ()         
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-latex-commands)
               ac-sources)))
```

Unicode input is not restricted to LaTeX modes and is particularly useful in org-mode (with it's powerful exporting facilities), or web development tools where unicode is crucial.


Suppose you want it for  mode `XXX`:

```lisp
(require 'ac-math)

(add-to-list 'ac-modes 'XXX-mode)

(defun ac-XXX-mode-setup ()
   (add-to-list 'ac-sources 'ac-source-math-unicode))

(add-hook 'XXX-mode-hook 'ac-XXX-mode-setup)
```


## Other Sources ##


Here is how to make the TaTeX completion work everywhere in LaTeX documents (default is only in math mode):

```lisp
(defvar ac-source-math-latex-everywhere
'((candidates . ac-math-symbols-latex)
  (prefix . "\\\\\\(.*\\)")
  (action . ac-math-action-latex)
  (symbol . "l")))
```


Here is how to make unicode completion work with prefix "%" (prefix is deleted
automatically on completion):

```lisp
(defvar ac-source-math-unicode-on-%
'((candidates . ac-math-symbols-unicode)
  (prefix . "%\\(.*\\)")
  (action . ac-math-action-unicode)
  (symbol . "u")))
```

Please let me know if you want anything different from above.
