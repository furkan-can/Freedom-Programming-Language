%{
void yyerror (char *s);
int yylex();
int yyerrok;
int yyclearin;

#include <stdio.h>     /* C declarations used in actions */
#include <stdlib.h>
#include <ctype.h>



int symbols[52];
int symbolVal(char symbol);
void updateSymbolVal(char symbol, int val);
int i = 0;
int dataEXP[2];
int dataFUN[3];
int dataFUNC[2];

%}

/* Yacc definitions */


%union {int num; char id; char *pr;}         
%union {char *child;}

%start program

%token SCANNER COMMA MOD NOT_EQUALS LP RP OUTPUT AND WHILE IF ELSE EQUALS BIGGER_EQUALS SMALLER_EQUALS BIGGER SMALLER COMMENT START END OR SEMICOLON FUNC RETURN FUNCNAME EQUIV IMPL NOT BOOL

%token <num> EUCLID
%token <id> IDENTIFIER
%token <pr> STRING

%type <id> assignmentStatement
%type <num> exp term boolExpression
%type <num> boolStatement
%type <num> whileStatement

%%

/* descriptions of expected inputs     corresponding actions (in C) */



program: /* empty */
	| START program END
        | statements program
	| program statements
	| statements
	| error /*error handling*/
        ;


statements:
	statements
        | printnumberStatement
        | scannerStatement
        | IfElseStatement
        | whileStatement
        | commentStatement
        | assignmentStatement
    	| printStringStatement
    	| boolStatement
	| funcStatement
	| funcSingleParameterStatement
	| funcDoubleParameterStatement
        ;


expression:
    	comparisonExpression
        | orExpression
        | andExpression
        | boolExpression
        ;


printStringStatement:
    	OUTPUT STRING            	{ printf("%s\n",$2); }
    	;

printnumberStatement:
        OUTPUT term     			{printf("%d\n", $2);}
        ;

assignmentStatement:
        IDENTIFIER '=' exp          	{ updateSymbolVal($1,$3); }
        ;

exp:
         term                         	{$$ = $1; dataEXP[0]=$1;}
        | exp '+' term              	{$$ = $1 + $3; dataEXP[1]=$3;}
        | exp '-' term              	{$$ = $1 - $3; dataEXP[1]=($3*-1);}
	| exp MOD term			{$$ = (int)($1 % $3); dataFUN[2]=(int)($1 % $3);}
	| FUNCNAME LP term COMMA term RP  		{$$=dataFUN[1];}
        ;
term :
    	EUCLID                        	{$$ = $1;}
        | IDENTIFIER                	{$$ = symbolVal($1);}
        ;


boolExpression:
          term EQUALS term            	{ $$ = $1 == $3;}
        | term BIGGER term             	{ $$ = $1 > $3;}
        | term SMALLER term             { $$ = $1 < $3;}
        | term BIGGER_EQUALS term       { $$ = $1 >= $3;}
        | term SMALLER_EQUALS term      { $$ = $1 <= $3;}
	| term AND term			{ $$ = $1 && $3;}
	| term OR term			{ $$ = $1 || $3;}	
        ;



funcStatement:
	FUNC FUNCNAME statements RETURN statements SEMICOLON  
	;

funcSingleParameterStatement:
	FUNC FUNCNAME LP term RP RETURN {dataFUNC[0]=$4;}
	;				 

funcDoubleParameterStatement:
	FUNC FUNCNAME LP term COMMA term RP RETURN IfElseStatement {dataFUN[0]=$4;
									      dataFUN[1]=$6;}
	;


commentStatement:
        COMMENT
        ;

scannerStatement:
        SCANNER
        ;
    

boolStatement:
    
     	EUCLID EQUALS EUCLID  		{ $$ = $1 == $3 ;
                    			if($$==1){
                                	printf("TRUE\n");
                                	}
                               		else{
                                	printf("FALSE\n");
                                	}
                			}
    	| EUCLID BIGGER EUCLID       	{ $$ = $1 > $3;
                    			if($$==1){
                                	printf("TRUE\n");
                                	}
                               		else{
                                	printf("FALSE\n");
                                	}
                			}
    	| EUCLID SMALLER EUCLID    		{$$ = $1 < $3;
                    			if($$==1){
                                	printf("TRUE\n");
                                	}
                               		else{
                                	printf("FALSE\n");
                                	}
                    			}
    	| EUCLID BIGGER_EQUALS EUCLID   		{ $$ = $1 >= $3;
                    			if($$==1){
                                	printf("TRUE\n");
                                	}
                               		else{
                                	printf("FALSE\n");
                                	}
                			}
    	| EUCLID SMALLER_EQUALS EUCLID    	{ $$ = $1 <= $3;
                    			if($$==1){
                                	printf("TRUE\n");
                                	}
                               		else{
                                	printf("FALSE\n");
                                	}
                			}
    	| EUCLID AND EUCLID    		{ $$ = $1 && $3;
                    			if($$==1){
                                	printf("TRUE\n");
                                	}
                               		else{
                                	printf("FALSE\n");
                                	}
                			}
    	| EUCLID OR EUCLID		    	{ $$ = $1 || $3;
                    			if($$==1){
                                	printf("TRUE\n");
                                	}
                               		else{
                                	printf("FALSE\n");
                                	}
                			}
    	| '(' boolStatement ')'    	{ $$ = $2;
                    			if($$==1){
                                	printf("TRUE\n");
                                	}
                               		else{
                                	printf("FALSE\n");
                                	}
                			}
    	;


IfElseStatement:
        IF boolExpression exp ELSE exp 		                { if($2==1){
                                            			printf("%d\n", $3);
                                               			}else {
                                               			printf("%d\n", $5);} }
	;

	|IF boolExpression OUTPUT term ELSE OUTPUT term 			{ if($2==1){
                                            				printf("%d\n", $4);
                                               				}else {
                                               				printf("%d\n", $7);} }
	;

	| IF term EQUALS term exp ELSE 				{ if($2==$4){
								  printf("%d\n", $5);
								}}
	;
        | IF LP term MOD term RP EQUALS term 
	;
	| IF term EQUALS term OUTPUT STRING ELSE OUTPUT STRING	{if(dataFUNC[1] == dataFUNC[0]){
								  printf("%s\n",$6);}
								 else{printf("%s\n",$9);}}   
	;          


whileStatement:
         WHILE term SMALLER term RETURN exp SEMICOLON        {if($2 < $4){printf("%d\n" , $$ = (($4-$2)*dataEXP[1])+dataEXP[0]);}}
 
        | WHILE term BIGGER term RETURN exp SEMICOLON       {if($2 > $4){printf("%d\n", $$ = (dataEXP[0]+($4-$2)*dataEXP[1]));}}
    
    	| WHILE term SMALLER term RETURN OUTPUT exp SEMICOLON {            while(i<$4-$2) {
                                        			printf("%d\n",$7);
                                        				i +=1;} 
                                        				i == 0;}
 
    	| WHILE term BIGGER term RETURN OUTPUT exp SEMICOLON {            while(i<$2-$4) {
                                        				printf("%d\n",$7);
                                        				     i +=1;} 
									i==0; }

	| WHILE term SMALLER term RETURN OUTPUT STRING SEMICOLON {           while(i<$4-$2){
									printf("%s\n",$7);
									i +=1;} i==0;}

	| WHILE term BIGGER term RETURN OUTPUT STRING SEMICOLON {           while(i<$2-$4){
									printf("%s\n",$7);
									i +=1;} i==0;}

	| WHILE term NOT_EQUALS term RETURN term '=' term term '=' term assignmentStatement term {           
									while(dataFUN[2] > 0){
									dataFUN[0]=dataFUN[1];
									dataFUN[1]=dataFUN[2];
									dataFUN[2]=(int)((int)dataFUN[0] % (int)dataFUN[1]);
									if(dataFUN[2] <$4){dataFUN[2]=dataFUN[2]+1;}else{$4=$4+1;}}
									printf("%d\n",dataFUN[1]);}

	| WHILE term SMALLER term RETURN 					{ i=1; dataFUNC[1]=0;
									   while(i<dataFUNC[0]){
									    if((dataFUNC[0] % i) == 0){
										dataFUNC[1] += i; }
										i+=1;
									}}
	


comparisonExpression:
        EUCLID assignmentOperator EUCLID
    	| IDENTIFIER assignmentOperator EUCLID
    	| IDENTIFIER assignmentOperator EUCLID  
        ;

orExpression:
        BOOL OR BOOL
        ;

andExpression:
        BOOL AND BOOL
        ;

assignmentOperator :
        EQUALS | BIGGER_EQUALS | SMALLER_EQUALS | BIGGER | SMALLER
        ;



%%                     /* C code */


int computeSymbolIndex(char token)
{
    int idx = -1;
    if(islower(token)) {
        idx = token - 'a' + 26;
    } else if(isupper(token)) {
        idx = token - 'A';
    }
    return idx;
}

/* returns the value of a given symbol */
int symbolVal(char symbol)
{
    int bucket = computeSymbolIndex(symbol);
    return symbols[bucket];
}

/* updates the value of a given symbol */
void updateSymbolVal(char symbol, int val)
{
    int bucket = computeSymbolIndex(symbol);
    symbols[bucket] = val;
}

int main (void) {
    /* init symbol table */
    int i;
    for(i=0; i<52; i++) {
        symbols[i] = 0;
    }

    return yyparse ( );
}

extern int lineCounter;
void yyerror (char *s)
{
printf ("%s on line %d\n", s, lineCounter);
exit(EXIT_SUCCESS);
}


