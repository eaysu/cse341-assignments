%{
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    int count = 0;
    char error[128];

    void func(char * s) {
        for (int i = 0; s[i] != 0;++i) {
            error[count] = s[i];
            count++;
        }
    }
    void errorMessage() {
        if (count != 0) {
            printf("SYNTAX_ERROR %s cannot be tokenized\n", error);
        }
    }
%}

%% 
 
"defvar" {errorMessage(); if(count > 0) {return 0;} return DEFV;}   
"deffun" {errorMessage(); if(count > 0) {return 0;} return DEFF;} 
"while"  {errorMessage(); if(count > 0) {return 0;} return KW_WHILE;}  
"if"     {errorMessage(); if(count > 0) {return 0;} return KW_IF;}  
"exit"   {errorMessage(); if(count > 0) {return 0;} return KW_EXIT;}
"true"   {errorMessage(); if(count > 0) {return 0;} yylval.booVal = 1; return KW_TRUE;}  
"false"  {errorMessage(); if(count > 0) {return 0;} yylval.booVal = 0; return KW_FALSE;}

"and"    {errorMessage(); if(count > 0) {return 0;} return OP_AND;}
"or"     {errorMessage(); if(count > 0) {return 0;} return OP_OR;}
"not"    {errorMessage(); if(count > 0) {return 0;} return OP_NOT;}
"equal"  {errorMessage(); if(count > 0) {return 0;} return OP_EQ;}
"gt"     {errorMessage(); if(count > 0) {return 0;} return OP_GT;}
"set"    {errorMessage(); if(count > 0) {return 0;} return OP_SET;}

[+]      {errorMessage(); if(count > 0) {return 0;} return OP_PLUS;}
[-]      {errorMessage(); if(count > 0) {return 0;} return OP_MINUS;}
[/]      {errorMessage(); if(count > 0) {return 0;} return OP_DIV;}
[*]      {errorMessage(); if(count > 0) {return 0;} return OP_MULT;}
[(]      {errorMessage(); if(count > 0) {return 0;} return OP;}
[)]      {errorMessage(); if(count > 0) {return 0;} return CP;}
[,]      {errorMessage(); if(count > 0) {return 0;} return OP_COMMA;}

[;][;].* {errorMessage(); if(count > 0) {return 0;}}

[1-9][0-9]*[f][1-9][0-9]* {errorMessage(); if(count > 0) {return 0;} yylval.fVal = yytext; return VALUEF;}
[0]*[f][1-9][0-9]* {errorMessage(); if(count > 0) {return 0;} yylval.fVal = yytext; return VALUEF;}

[a-zA-Z_][a-zA-Z0-9_]* {errorMessage(); if(count > 0) {return 0;} strncpy(yylval.id, yytext, 20); return ID;}

[0-9][a-zA-Z0-9_]* {printf("SYNTAX ERROR %s cannot be tokenized\n", yytext); return 0;}

[ \t\n] ;

. {func(yytext);}

%%

int yywrap() {return 0;}



