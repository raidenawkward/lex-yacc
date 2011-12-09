%{
#define YYSTYPE  double	//很多参考资料都没有正确解释重定义YYSTYPE的正确方法，我这样定义是安全的。
#define  BIGINT long long
#include <ctype.h>
#include "y.tab.h"	//这是yacc生成的文件，必须包含！
int i ;
BIGINT val;
%}

digit		[0-9]
xdigit		[0-9a-fA-F]
odigit		[0-7]

decnum	(0(\.{digit}+)?)|([1-9]{digit}*(\.{digit}+)?)
octnum	0{odigit}+
hexnum	0(x|X){xdigit}+

reg		[a-zA-Z]
opt1	"+"|"-"|"*"|"/"|"&"|"|"|"%"|"^"|"~"|"!"|"<"|">"
opt2	(&&)|(\|\|)|(\<\<)|(\>\>)

exit	((E|e)(X|x)(I|i)(T|t))|((Q|q)(U|u)(I|i)(T|t))
clear	(C|c)(L|l)(E|e)(A|a)(R|r)
list	(L|l)(I|i)(S|s)(T|t)
erase	(E|e)(R|r)(A|a)(S|s)(E|e)
hex		(H|h)(E|e)(X|x)
oct		(O|o)(C|c)(T|t)
dec		(D|d)(E|e)(C|c)
help	(H|h)(E|e)(L|l)(P|p)

%%


[" "; \t]	{}
{decnum}	{sscanf(yytext,"%lf",&yylval);return(NUM); }
{octnum}	{
	i=1;val=0;
	while(i<yyleng)
	{
		val=(val<<3)+yytext[i]-'0';
		i++;
	}
	yylval=val;
	return(NUM);
}

{hexnum}	{
	i=2;val=0;
	while(i<yyleng)
	{
		if(islower(yytext[i])) val=(val<<4)+yytext[i]-'a'+10;
		else if(isupper(yytext[i])) val=(val<<4)+yytext[i]-'A'+10;
		else val=(val<<4)+yytext[i]-'0';
		i++;
	}
	yylval=val;
	return(NUM);
}

{reg}		{
	if(islower(yytext[0]))yylval=yytext[0]-'a';
	else yylval=yytext[0]-'A';
	return(REG);
}

{opt1}	{
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
		case '^':
			return BITXOR;
		break;
		case '&':
			return BITAND;
		break;
		case '|':
			return BITOR;
		break;
		case '<':
			return LESS;
		break;
		case '>':
			return MORE;
		break;
		case '!':
			return NOT;
		break;
		case '~':
			return BITREV;
		break;
	}
}

{opt2}	{
	switch(yytext[0])
	{
		case '&':
			return AND;
		break;
		case '|':
			return OR;
		break;
		case '<':
			return LSHIFT;
		break;
		case '>':
			return RSHIFT;
		break;
	}		
}

{clear}	{return(CLEAR);}
{exit}	{return(EXIT);}
{list}		{return(LIST);}
{erase}	{return(ERASE);}
{hex}	{return(HEX);}
{oct}		{return(OCT);}
{dec}	{return(DEC);}
{help}	{return(HELP);}

.|\n		{return(yytext[0]);}
%%辅助部分在与yacc协同工作时可以省略
