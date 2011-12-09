%{
#include "lex.yy.c"
%}

%token          	NUM ADD SUB MUL DIV MOD
%left           	    ADD SUB
%left          	                MUL DIV MOD

%%

lines		: lines E '\n'	{ printf("\n"); }
			| lines '\n'	{ printf("\n"); }
			|
			;

E			: E ADD T { printf("+"); }
			| E SUB T { printf("-"); }
			| T
			;

T			: T MUL F { printf("*"); }
			| T DIV F { printf("/"); }
			| T MOD F { printf("%%"); }
			| F
			;

F			: NUM {printf("%d",yylval);}
			| '(' E ')'
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
	printf("\a");
	yyparse();
}
