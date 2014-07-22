;#############################
;###   TextOverride Tool   ###
;#############################
;
;version 2.8.1
;
;by Matthew D. Jordan
;
;A simple interface to modify a dimension's text override
;value directly.  It even features shortcuts for frequently
;used overrides.  Clear a text override by entering nothing.
;If you want to enter a value with spaces, use the Literal
;option.

;Remember, use text overrides only for good, not evil.

;Note the lack of error handling.
;Does that make me a bad person?


(defun c:TEXTOVERRIDE (/ temp NewDimValue eset eset2 to_shortcut_list)

	;set shortcuts and text for each variable
	;("shortcut" "replacement text" )
	;NB - "literalflag" & "matchflag" are keywords used by this script, do not change them - Thanks!
	(setq to_shortcut_list '(
		("c"   "<>  OC"       )
		("ct"  "<> OC TYP"   )
		("ctc"  "<> CTC"   )
		("g"   "<> GAP"         )
		("gt"  "<> GAP TYP"    )
		("t"   "<> TYP"        )
		("th"  "<> THRU."       )
		("nct" "<>\\POC TYP" )
		("s"   "<> (SKIN)"      )
		(""		"<>"              )
		("p"	"(<>)"            )
		("m"	"matchflag"		    )
		("l"	"literalflag"	    )))

	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(setq NewDimValue (getstring T "\nInput Text Overide \[Typ./o.C./o.C. Typ./Newline o.C. Typ/THru/Skin/(P)/Gap/Gap Typ./Literal/Match\] <reset>: "))
	
	;Parse to_shortcut_list for a match to user entry
	(foreach tmp to_shortcut_list
		(if (eq (car tmp)  (strcase NewDimValue T))
				(setq NewDimValue (cadr tmp))))

	;Literal Flag
	(if (eq NewDimValue (strcase "literalflag" T))
			(setq NewDimValue (getstring T "\nInput Literal Text Overide: ")))

	;Match Flag
	(if (eq NewDimValue (strcase "matchflag" T))
			(progn
				(while	(/= "DIMENSION" (cdr (assoc 0 eset2)))
								(setq eset2 (entget (car (entsel "\nSelect source dimension: ")))))
				(setq NewDimValue (cdr (assoc 1 eset2)))))

	(to:text_override_function NewDimValue eset)
	(princ)
)

(defun to:text_override_function ( val eset / )
	;set textoverides via entmod
	(setq i 0)
	(repeat (sslength eset)
		(setq temp (entget (ssname eset i)))
		(setq temp (subst (cons 1 val) (assoc 1 temp) temp))
		(entmod temp)
		(setq i(+ i 1)))

	(princ)
)

(defun c:to_typical (/)
	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(to:text_override_function "<> TYP." eset)
)

(defun c:to_oncenter (/)
	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(to:text_override_function "<> O.C." eset)
)

(defun c:to_oncentertypical (/)
	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(to:text_override_function "<> O.C. TYP." eset)
)

(defun c:to_skin (/)
	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(to:text_override_function "<> SKIN" eset)
)

(defun c:to_gap (/)
	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(to:text_override_function "<> GAP" eset)
)

(defun c:to_gaptypical (/)
	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(to:text_override_function "<> GAP TYP." eset)
)


(defun c:to_parenth (/)
	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(to:text_override_function "(<>)" eset)
)

(defun c:to_reset (/)

	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(to:text_override_function "" eset)
)


(defun c:to_ream (/)

	(setq eset (ssget '((0 . "DIMENSION"))))
	(while (eq eset nil)
				 (prompt "  Nothing Selected!")
				 (setq eset (ssget '((0 . "DIMENSION")))))

	(to:text_override_function "REAM <>" eset)
)