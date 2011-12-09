%{
#include "lex.yy.c"
%}

%token	INCLUDE HEADERFILE CH_LESS CH_MORE CH_QUOTER
%start	code

%%

code		:		code INCLUDE include_file
			|		INCLUDE include_file
			;

include_file		:		CH_LESS HEADERFILE CH_MORE	{	printf("mode 1 found\n");	}
					|		CH_QUOTER HEADERFILE CH_QUOTER	{	printf("mode 2 found\n");	}
					;

%%

int yyerror(char *str)
{
    fprintf(stderr,"Error: %s\n",str);
    return 1;
}

int yywrap()
{
   return 1;
}
int main()
{
	yyparse();
}
