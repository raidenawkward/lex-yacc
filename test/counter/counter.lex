%{
#include <stdio.h>
#include <stdlib.h>
int wordCount = 0;
int lineCount = 0;
%}
specialBC "啥"
chars [A-za-z\_\'\.\";]
numbers ([0-9])+
delim [" "\t]
line [\n\r]
whitespace {delim}+
words {chars}+
%%
{specialBC} {
	printf("special %s found\n",yytext);
}
{words} {
	wordCount++;
	printf("word found : %s\n",yytext);
}
{whitespace} {
}
{numbers} { /* one may
want to add some processing here*/ }
{line} {
	lineCount++;
}
%%
void main(int argc, char** argv)
{
	int i;
	for (i = 0; i < argc; ++i)
		printf("param %d : %s\n",i,argv[i]);

	yylex(); /* start the analysis*/
	printf("count of words:%d\n", wordCount);
	printf("count of line:%d\n", lineCount);
}

int yywrap()
{
	return 1;
}
