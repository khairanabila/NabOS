%macro macro_debug 1
%ifdef DEBUG
    jmp %%skip
    db " [", %1, "] "

%%skip:
%endif
%endmacro