%{
#include "y.tab.h"
#include "string.h"
int lineCounter = 1;
void yyerror (char *s);
int yylex();

%}

START (START)([^a-zA-Z0-9])
END END
OUTPUT OUTPUT:
newline [\n]
SCANNER SCANNER:([^a-zA-Z0-9])
STRING  \".*\"
IDENTIFIER [a-zA-Z]
AND AND([^a-zA-Z0-9])
OR OR([^a-zA-Z0-9])
NOT NOT([^a-zA-Z0-9])
EUCLID [0-9]+
IF IF[^a-zA-Z0-9]
ELSE ELSE[^a-zA-Z0-9]
WHILE WHILE[^a-zA-Z0-9]
EQUALS ==
BIGGER_EQUALS >=
SMALLER_EQUALS <=
BIGGER >
SMALLER <
COMMENT [^a-zA-Z0-9]([//].+[//])[^a-zA-Z0-9]
SEMICOLON ;
FUNC FUNC
RETURN RETURN
FUNCNAME [a-z]+[:]
BOOL true|false

%%
!=	{return NOT_EQUALS;}
\%      {return MOD;}
\(	{return LP;}
\)	{return RP;}
\,	{return COMMA;}
{FUNCNAME} {return FUNCNAME;}
{RETURN} {return RETURN;}
{FUNC} {return FUNC;}
{STRING} {yylval.pr = strdup(yytext); return STRING ;}
{OUTPUT} {return OUTPUT;}
{SCANNER} {return SCANNER ;}
{EUCLID}  {yylval.num = atoi(yytext);return EUCLID;}
{WHILE} {return WHILE ;}
{IF} {return IF ;}
{ELSE} {return ELSE ;}
{EQUALS} {return EQUALS ;}
{BIGGER_EQUALS} {return BIGGER_EQUALS ;}
{SMALLER_EQUALS} {return SMALLER_EQUALS ;}
{BIGGER} {return BIGGER ;}
{SMALLER} {return SMALLER ;}
{AND} {return AND ;}
{OR} {return OR ;}
{NOT} {return NOT ;}
{COMMENT} {return COMMENT ;}
{IDENTIFIER} {yylval.id = yytext[0]; return IDENTIFIER;}
{START} {return START ;}
{END} {return END ;}
{SEMICOLON} {return SEMICOLON;}
{newline} {lineCounter++;}
[-+=]                  {return yytext[0];}
[ \t\n]                ;


%%


int yywrap (void) {return 1;}

