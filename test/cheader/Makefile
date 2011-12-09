
LEX := flex
YACC := yacc -d
CC := gcc
EXEC := b

default:
	$(LEX) *.lex
	$(YACC) *.y
	$(CC) *.tab.c -o $(EXEC)
clean:
	rm -fr *.o *.h *.c $(EXEC)
