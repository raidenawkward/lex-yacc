%{
#include "y.tab.h"
//#define DEBUG
%}

ch_less		"<"
ch_more		">"
ch_quoter	"\""
blank		[ \t\n]
string		[0-9A-Za-z\._]
include		#{blank}*include
include_file	{string}+

%%

{ch_less}	{
		#ifdef DEBUG
		printf("less found\n");
		#endif
		return CH_LESS;
	}

{ch_more}	{
		#ifdef DEBUG
		printf("more found\n");
		#endif
		return CH_MORE;
	}

{ch_quoter}	{
		#ifdef DEBUG
		printf("quoter found\n");
		#endif
		return CH_QUOTER;
	}

{include}	{
		#ifdef DEBUG
		printf("include found\n");
		#endif
		return INCLUDE;
	}

{include_file}	{
		#ifdef DEBUG
		printf("include file %s found\n",yytext);
		#endif
		return HEADERFILE;
	}

.		{}

%%
#if 0
void main() {
	printf("start\n");
	yylex();
}

int yywrap() {
	return 1;
}
#endif
