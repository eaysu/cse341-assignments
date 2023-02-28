%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    char * valueF;
    int yylex();
    void yyerror();

    int cD;
    int firstNum, secondNum;
    int firstDenum, secondDenum;

    typedef struct {
        int numerator;
        int denumerator;
    } numStruct;

    typedef struct {
        char identifier[20];
        numStruct value;
    } idStruct;

    idStruct newVal(char newId[20], numStruct newValueF); 
    numStruct parseValueF(char * valueF);
    int commonDiv(int num, int denum);
    idStruct values[50];

    idStruct newVal(char newId[20], numStruct newValueF);
    int findIdIndex(char id[20]);
    idStruct returnValue(char id[20]);
    void setValue(char id[20], numStruct variable);
    void createValue(char id[20], numStruct variable);
    void resetValue();

%}

%union {
    struct {
        int numerator;
        int denumerator;
    } ns; 

    int intVal;
    char *fVal; 
    char id[20]; 
    char booVal;
}

%token DEFV;
%token DEFF;
%token KW_WHILE;
%token KW_IF;
%token KW_EXIT;
%token <booVal> KW_TRUE;
%token <booVal> KW_FALSE;
%token OP_AND;
%token OP_OR;
%token OP_NOT;
%token OP_EQ;
%token OP_GT;
%token OP_SET;
%token OP_PLUS;
%token OP_MINUS;
%token OP_DIV;
%token OP_MULT;
%token OP;
%token CP;
%token OP_COMMA;
%token <fVal> VALUEF;
%token <id> ID;

%type <intVal> INPUT;
%type <ns> EXP;
%type <booVal> EXPB;

%%

START: INPUT START {printf("Syntax OK.\n");}
       | OP KW_EXIT CP {exit(0);}; 

INPUT: EXP {cD = commonDiv($1.numerator, $1.denumerator); printf("Result: %df%d\n", $1.numerator / cD, $1.denumerator / cD);}
       | EXPB {printf("%d\n", $1);}
       | OP DEFV ID EXP CP {numStruct nst; nst.numerator = $4.numerator; nst.denumerator = $4.denumerator; createValue($3, nst);};

EXP:   OP OP_PLUS EXP EXP CP {numStruct n; 
                              n.numerator = $3.numerator; n.denumerator = $3.denumerator; firstNum = n.numerator; firstDenum = n.denumerator;
                              n.numerator = $4.numerator; n.denumerator = $4.denumerator; secondNum = n.numerator; secondDenum = n.denumerator;
                              n.numerator = firstNum * secondDenum + secondNum * firstDenum;
                              n.denumerator = firstDenum * secondDenum; $$.numerator = n.numerator; $$.denumerator = n.denumerator;}   
       | OP OP_MINUS EXP EXP CP {numStruct n; 
                              n.numerator = $3.numerator; n.denumerator = $3.denumerator; firstNum = n.numerator; firstDenum = n.denumerator;
                              n.numerator = $4.numerator; n.denumerator = $4.denumerator; secondNum = n.numerator; secondDenum = n.denumerator;
                              n.numerator = firstNum * secondDenum - secondNum * firstDenum;
                              n.denumerator = firstDenum * secondDenum; $$.numerator = n.numerator; $$.denumerator = n.denumerator;}
       | OP OP_DIV EXP EXP CP {numStruct n; 
                              n.numerator = $3.numerator; n.denumerator = $3.denumerator; firstNum = n.numerator; firstDenum = n.denumerator;
                              n.numerator = $4.numerator; n.denumerator = $4.denumerator; secondNum = n.numerator; secondDenum = n.denumerator;
                              n.numerator = firstNum * secondDenum;
                              n.denumerator = secondNum * firstDenum; $$.numerator = n.numerator; $$.denumerator = n.denumerator;}  
       | OP OP_MULT EXP EXP CP {numStruct n; 
                              n.numerator = $3.numerator; n.denumerator = $3.denumerator; firstNum = n.numerator; firstDenum = n.denumerator;
                              n.numerator = $4.numerator; n.denumerator = $4.denumerator; secondNum = n.numerator; secondDenum = n.denumerator;
                              n.numerator = firstNum * secondNum;
                              n.denumerator = firstDenum * secondDenum; $$.numerator = n.numerator; $$.denumerator = n.denumerator;}
       | ID {idStruct val = returnValue($1); $$.numerator = val.value.numerator; $$.denumerator = val.value.denumerator;} 
       | VALUEF {numStruct ns = parseValueF($1); $$.numerator = ns.numerator; $$.denumerator = ns.denumerator;};

EXPB:  OP OP_EQ EXP EXP CP {$$ = ((double)$3.numerator / (double)$3.denumerator) == ((double)$4.numerator / (double)$4.denumerator);}
       | OP OP_GT EXP EXP CP {$$ = ((double)$3.numerator / (double)$3.denumerator) > ((double)$4.numerator / (double)$4.denumerator);}         
       | OP OP_AND EXPB EXPB CP {$$ = $3 && $4;}
       | OP OP_OR EXPB EXPB CP {$$ = $3 || $4;}
       | OP OP_NOT EXPB CP {$$ = !$3;}
       | KW_TRUE {$$ = $1;}
       | KW_FALSE {$$ = $1;};
%%

int main () {
    resetValue();
    yyparse();
    return 0;
}

void yyerror() {
    printf("SYNTAX_ERROR Expression not recognized \n");
}

int commonDiv(int num, int denum) {

    if (num == 0) {
        return denum;
    }

    else if (denum == 0) {
        return num;
    }

    if (num > denum) {
        return commonDiv(denum, num % denum);
    }

    else {
        return commonDiv(num, denum % num);
    }
}

numStruct parseValueF(char * valueF) {
    
    numStruct nm;

    char str[20] = {0};
    char first[10] = {0};
    char second[10] = {0};
    int i, j;
    strcpy(str, valueF);
    int len = strlen(valueF);

    for (i = 0, j = 0; i < len; i++) {
        if (str[i] == 'f') {
            str[i] = ' ';
            strncpy(first, str, i);
            strncpy(second, str + i + 1, len - i - 1);
            break;
        }
    }

    nm.numerator = atoi(first);
    nm.denumerator = atoi(second);

    return nm;
}

idStruct newVal(char newId[20], numStruct newValueF) {
    idStruct idS;
    strcpy(idS.identifier, newId);
    idS.value.numerator = newValueF.numerator;
    idS.value.denumerator = newValueF.denumerator;
    return idS;
}

int findIdIndex(char id[20]) {
    int i;
    int index = -1;
    for(i = 0; i < 50;i++) {
        if(strcmp(values[i].identifier, id) == 0) {
            return index = i;
        }
    }
    return index;
}

idStruct returnValue(char id[20]) {
    int i = findIdIndex(id);

    if(i == -1) {
        exit(0);
    }

    else {
        return values[i];
    }
}

void setValue(char id[20], numStruct variable) {
    int i = findIdIndex(id);

    if(i == -1) {
        printf("ERROR unknown id\n");
    }

    else {
        values[i].value.numerator = variable.numerator;
        values[i].value.denumerator = variable.denumerator;
    }
}

void createValue(char id[20], numStruct variable) {
    int nullIndex;
    if(findIdIndex(id) != -1) {
        printf("ERROR already declared\n");
        exit(0);
    }

    nullIndex = findIdIndex("");
    values[nullIndex] = newVal(id, variable);
}

void resetValue() {
    int i;
    for(i = 0;i < 50;i++) {
        strcpy(values[i].identifier, "");
    }
}
