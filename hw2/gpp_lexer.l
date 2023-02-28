%{
    int count = 0;
    int op_oc_flag = 0;
    char error[128];
    void func(char * s) {
        for(int i = 0; s[i] != 0;++i) {
            error[count] = s[i];
            count++;
        }
    }
    void errorMessage() {
        if(count != 0) {
            printf("SYNTAX_ERROR %s cannot be tokenized\n", error);
        }
    }
%}

%% 

"and"    {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_AND\n", yytext);}
"or"     {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_OR\n", yytext);}
"not"    {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_NOT\n", yytext);}
"equal"  {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_EQUAL\n", yytext);}
"less"   {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_LESS\n", yytext);} 
"nil"    {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_NIL\n", yytext);} 
"list"   {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_LIST\n", yytext);} 
"append" {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_APPEND\n", yytext);} 
"concat" {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_CONCAT\n", yytext);} 
"set"    {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_SET\n", yytext);}  
"deffun" {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_DEFFUN\n", yytext);} 
"for"    {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_FOR\n", yytext);}  
"if"     {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_IF\n", yytext);}  
"exit"   {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_EXIT\n", yytext);}  
"load"   {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_LOAD\n", yytext);}  
"disp"   {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_DISP\n", yytext);}  
"true"   {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_TRUE\n", yytext);}  
"false"  {errorMessage(); if(count > 0) {return 0;} printf("%s: KW_FALSE\n", yytext);}

[+]      {errorMessage(); if(count > 0) {return 0;} printf("%s: OP_PLUS\n", yytext);}
[-]      {errorMessage(); if(count > 0) {return 0;} printf("%s: OP_MINUS\n", yytext);}
[/]      {errorMessage(); if(count > 0) {return 0;} printf("%s: OP_DIV\n", yytext);}
[*]      {errorMessage(); if(count > 0) {return 0;} printf("%s: OP_MULT\n", yytext);}
[(]      {errorMessage(); if(count > 0) {return 0;} printf("%s: OP_OP\n", yytext);}
[)]      {errorMessage(); if(count > 0) {return 0;} printf("%s: OP_CP\n", yytext);}
[*][*]   {errorMessage(); if(count > 0) {return 0;} printf("%s: OP_DBLMULT\n", yytext);}
[,]      {errorMessage(); if(count > 0) {return 0;} printf("%s: OP_COMMA\n", yytext);}
["]      {errorMessage(); if (op_oc_flag == 0) {printf("%s: OP_OC\n", yytext); op_oc_flag = 1;} else {printf("%s: OP_CC\n", yytext); op_oc_flag = 0;}}

[;][;].* {errorMessage(); if(count > 0) {return 0;} printf("%s: COMMENT\n", yytext);}

[1-9][0-9]*  {errorMessage(); if(count > 0) {return 0;} printf("%s: VALUEI\n", yytext);}
[0]          {errorMessage(); if(count > 0) {return 0;} printf("%s: VALUEI\n", yytext);}
[1-9][0-9]*[f][1-9][0-9]* {errorMessage(); if(count > 0) {return 0;} printf("%s: VALUEF\n", yytext);}
[0]*[f][1-9][0-9]* {errorMessage(); if(count > 0) {return 0;} printf("%s: VALUEF\n", yytext);}
["]+.*+["] {errorMessage(); if(count > 0) {return 0;} printf("\": OP_OC\n"); printf("%s: VALUESTR\n", yytext); printf("\": OP_CC\n"); }

[a-zA-Z_][a-zA-Z0-9_]* {errorMessage(); if(count > 0) {return 0;} printf("%s: IDENTIFIER\n", yytext);}

[0-9][a-zA-Z0-9_]* {printf("SYNTAX ERROR %s cannot be tokenized", yytext); return 0;}

[ \t\n] {errorMessage(); if(count > 0) {return 0;} continue;} 

. {func(yytext);}

%%

int yywrap() {return 0;}

int main(int argc, char* argv[]) {
    if (argc == 2) {
        yyin = fopen(argv[1], "r"); 
    }
    yylex();
    fclose(yyin);
    return 0;
}

