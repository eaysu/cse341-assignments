/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     DEFV = 258,
     DEFF = 259,
     KW_WHILE = 260,
     KW_IF = 261,
     KW_EXIT = 262,
     KW_TRUE = 263,
     KW_FALSE = 264,
     OP_AND = 265,
     OP_OR = 266,
     OP_NOT = 267,
     OP_EQ = 268,
     OP_GT = 269,
     OP_SET = 270,
     OP_PLUS = 271,
     OP_MINUS = 272,
     OP_DIV = 273,
     OP_MULT = 274,
     OP = 275,
     CP = 276,
     OP_COMMA = 277,
     VALUEF = 278,
     ID = 279
   };
#endif
/* Tokens.  */
#define DEFV 258
#define DEFF 259
#define KW_WHILE 260
#define KW_IF 261
#define KW_EXIT 262
#define KW_TRUE 263
#define KW_FALSE 264
#define OP_AND 265
#define OP_OR 266
#define OP_NOT 267
#define OP_EQ 268
#define OP_GT 269
#define OP_SET 270
#define OP_PLUS 271
#define OP_MINUS 272
#define OP_DIV 273
#define OP_MULT 274
#define OP 275
#define CP 276
#define OP_COMMA 277
#define VALUEF 278
#define ID 279




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 37 "gpp_interpreter.y"
{
    struct {
        int numerator;
        int denumerator;
    } ns; 

    int intVal;
    char *fVal; 
    char id[20]; 
    char booVal;
}
/* Line 1529 of yacc.c.  */
#line 109 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

