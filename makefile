freedom: lex.yy.c y.tab.c
	gcc -g lex.yy.c y.tab.c -o freedom

lex.yy.c: y.tab.c freedom.l
	lex freedom.l

y.tab.c: freedom.y
	yacc -d freedom.y

clean: 
	rm -rf lex.yy.c y.tab.c y.tab.h freedom freedom.dSYM