
NOTE: _Ac-math users are encouraged to switch to
[`company-math`](https://github.com/vspinu/company-math). [`company-mode`](http://company-mode.github.io/)
is a better framework and solves a number of notorious issues in
[`auto-complete`](http://cx4a.org/software/auto-complete/)_.

-------

This add-on defines three ac-sources for the *[auto-complete](https://github.com/auto-complete)* package:

 * `ac-source-latex-commands`		  - input latex commands 
 * `ac-source-math-latex`		 - input math latex tags  (by default, active only in math environments)

      ![symbols](https://raw.github.com/vitoshka/ac-math/master/img/latex-symbols.png)

 * `ac-source-math-unicode` - input of unicode symbols (_by default, active everywhere except math environments_)

      ![math](https://raw.github.com/vitoshka/ac-math/master/img/unicode-math.png)

Start math completion by typing the prefix "\" key. Select the completion type RET (`ac-complete`). Depending on the context the unicode symbol or latex \tag will be inserted.

## Activation ##

You must have  *[auto-complete](https://github.com/auto-complete)* package installed.

Ac-math is available thorough [MELPA](http://melpa.milkbox.net/) repository. You can also download [ac-math.el](https://raw.github.com/vitoshka/ac-math/master/ac-math.el) directly
and put it into your load-path directory.

This is an example of how to activate the 'ac-math' in latex-mode:

```lisp

(require 'ac-math) ; This is not needed when you install from MELPA

(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources)))

(add-hook 'TeX-mode-hook 'ac-latex-mode-setup)
```

If you are using 'flyspell' you might want to activate the [workaround](http://www.emacswiki.org/emacs/AutoComplete#toc6):
```lisp
(ac-flyspell-workaround)
```

## Unicode Input ##

By default unicode input (`ac-source-math-unicode`) is not activated in latex math environments. In order to activate it, do
 
```lisp
(setq ac-math-unicode-in-math-p t)
```

Unicode input is not restricted to LaTeX modes and is particularly useful in org-mode (with it's powerful exporting facilities), or web development tools where unicode is crucial.


Suppose you want it for  mode `XXX`:

```lisp
(add-to-list 'ac-modes 'XXX-mode)

(defun ac-XXX-mode-setup ()
   (add-to-list 'ac-sources 'ac-source-math-unicode))

(add-hook 'XXX-mode-hook 'ac-XXX-mode-setup)
```


## Custom sources ##

You can use symbols lists to define your own ac sources. 

Make math symbol completion work everywhere in LaTeX documents (default, `ac-source-math-latex` works only in math mode):

```lisp
(defvar ac-source-math-latex-everywhere
'((candidates . ac-math-symbols-latex)
  (prefix . ac-math-prefix)
  (action . ac-math-action-latex)
  (symbol . "l")))
```
