%{
#include "y.tab.h"
%}

digit			[0-9]
decnum  		(0(\.{digit}+)?)|([1-9]{digit}*(\.{digit}+)?)
opt            	"+"|"-"|"*"|"/"|"%"

%%

[" " \t]       	{}
{decnum}        {
					sscanf(yytext,"%d",&yylval); return(NUM);
				}
{opt}  			{
					switch(yytext[0])
					{
					case '+':
						return ADD;
						break;
					case '-':
						return SUB;
						break;
					case '*':
						return MUL;
						break;
					case '/':
						return DIV;
						break;
					case '%':
						return MOD;
						break;
					}
				}
.|\n       		{ return(yytext[0]); }
