%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern char *yytext; 
extern char *yyin;
char table_name[50];
char db_name[50];
char col_name1[50];
char col_name2[50];
char val1[50];
char val2[50];
char rel;

struct colnode{
    char col_name[50];
    char val[50];
}typedef Node;
Node store[100];
temp = 0;
sizeCol = 0;
sizeVal = 0;
%}
%token SELECT ALL AND WHERE GREATER LESSER EQUAL INSERT IDENTIFIER DATATYPE UPDATE END PRONOUN  USE INFO THE OF THAN TO COMMA CREATE WORD DATABASE TAB DELETE 

%%

s :  select PRONOUN all THE DATABASE END '\n' {printf("SHOW DATABASES\n");return;}
    | select PRONOUN all THE TAB WORD THE DATABASE END '\n' {printf("SHOW TABLES\n");return;}
    | select PRONOUN all THE INFO OF THE table END '\n' {printf("SELECT * FROM %s \n",table_name);return;} 
    | select PRONOUN THE col OF THE table END  '\n'  {    temp = 1;
                                                                printf("SELECT ");
                                                                while(temp<sizeCol){
                                                                    printf("%s, ",store[temp].col_name);
                                                                    temp++;
                                                                }
                                                                printf("%s FROM %s \n",store[temp].col_name,table_name);
                                                                temp = 0;
                                                                return;
                                                            } ;
    | select PRONOUN all THE INFO OF THE table where colu1 EQUAL rel THAN valu1 END '\n'  {printf("SELECT * FROM %s WHERE %s %c %s \n",table_name,col_name1,rel,val1);return;} 
    | select PRONOUN all THE INFO OF THE table where colu1 rel valu1 END '\n'  {printf("SELECT * FROM %s WHERE %s %c %s \n",table_name,col_name1,rel,val1);return;} 
    | select PRONOUN THE col OF THE table where colu1 EQUAL rel THAN valu1 END '\n'  {
                                                                temp = 1;
                                                                printf("SELECT ");
                                                                while(temp<sizeCol){
                                                                    printf("%s, ",store[temp].col_name);
                                                                    temp++;
                                                                }
                                                                printf("%s FROM %s WHERE %s %c %s \n",store[temp].col_name,table_name,col_name1,rel,val1);
                                                                temp = 0;
                                                                return;
                                                                } 
    | select PRONOUN THE col OF THE table where colu1 rel valu1 END '\n'  { temp = 1;
                                                                printf("SELECT ");
                                                                while(temp<sizeCol){
                                                                    printf("%s, ",store[temp].col_name);
                                                                    temp++;
                                                                }
                                                                printf("%s FROM %s WHERE %s %c %s \n",store[temp].col_name,table_name,col_name1,rel,val1);
                                                                temp = 0;
                                                                return;
                                                                }
    | insert THE WORD OF col WORD val WORD table END '\n' {
                                                                temp = 1;
                                                                printf("INSERT INTO %s (",table_name);
                                                                while(temp<sizeCol){
                                                                    printf("%s, ",store[temp].col_name);
                                                                    temp++;
                                                                }
                                                                printf("%s) VALUES (",store[temp].col_name);
                                                                temp = 1;
                                                                 while(temp<sizeVal){
                                                                    printf("%s, ",store[temp].val);
                                                                    temp++;
                                                                }
                                                                printf("%s)\n",store[temp].val);
                                                                temp = 0;

                                                                return;
    
                                                                }
    | update THE colu1 OF THE table where colu2 rel valu2 TO valu1 END '\n'  {printf("UPDATE %s SET %s=%s WHERE %s %c %s \n",table_name,col_name1,val1,col_name2,rel,val2);return;} 
    | update THE colu1 OF THE table where colu2 EQUAL rel THAN valu2 TO valu1 END '\n'  {printf("UPDATE %s SET %s=%s WHERE %s %c %s \n",table_name,col_name1,val1,col_name2,rel,val2);return;} 
    | create WORD DATABASE WORD db END '\n' {printf("CREATE DATABASE %s \n", db_name);return;} 
    | use THE DATABASE WORD db END '\n' {printf("USE %s \n", db_name);return;} 
    | create WORD TAB WORD table WORD WORD col WHERE DATATYPE WORD val END '\n' {
                                                                temp = 1;
                                                                printf("CREATE TABLE %s (",table_name);
                                                                while(temp<sizeCol){
                                                                    printf("%s %s, ",store[temp].col_name,store[temp].val);
                                                                    temp++;
                                                                }
                                                                printf("%s %s)\n",store[temp].col_name,store[temp].val);
                                                                temp = 0;
                                                                return;
                                                            }
    | delete THE WORD OF THE table where colu1 EQUAL rel THAN valu1 END '\n' {printf("DELETE FROM %s WHERE %s %c %s \n", table_name, col_name1,rel,val1);return;} 
    | delete THE WORD OF THE table where colu1 rel valu1 END '\n' {printf("DELETE FROM %s WHERE %s %c %s \n", table_name, col_name1,rel,val1);return;} 
    /* | create WORD TAB WORD table WORD WORD col WHERE DATATYPE WORD END'\n'  {printf("TEST\n");} */
    ;

select : SELECT ;
update: UPDATE;
insert: INSERT;
use : USE;
create : CREATE;
delete : DELETE;
db : IDENTIFIER {strcpy(db_name, yytext);}
all : ALL ;
table : IDENTIFIER {strcpy(table_name,yytext);}; 
col : colid COMMA col 
    | colid AND col
    | colid  {temp = 0;}; 
colid : IDENTIFIER {
                    temp++;
                    sizeCol++;
                    strcpy(store[temp].col_name,yytext);
                    } ;
where : WHERE ;
rel : GREATER {rel = '>';}
     | LESSER {rel = '<';}
     | EQUAL {rel = '=';};
val : valid COMMA val
    | valid AND val 
    |valid  {temp = 0;};
valid : IDENTIFIER {
                    temp++;
                    sizeVal++;
                    strcpy(store[temp].val,yytext);
                    }; 
colu1 : IDENTIFIER {strcpy(col_name1,yytext);};
colu2 : IDENTIFIER {strcpy(col_name2,yytext);};
valu1 :IDENTIFIER {strcpy(val1,yytext);};
valu2 : IDENTIFIER {strcpy(val2,yytext);};
%%

void yyerror (const char *str) {
	printf("error: %s\n", str);
}

int yywrap() {
	return 1;
}

main() {
    yyin=fopen("inputFile.txt","r");
    while(feof(yyin)==0)yyparse();
}