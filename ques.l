%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
%}

%option noyywrap

%%
create      return CREATE;
show       return SELECT; 
give       return SELECT; 
information return INFO;
update    return UPDATE;
delete      return DELETE;
all      return ALL; 
and     return AND; 
whose       return WHERE; 
having      return WHERE;
more       return GREATER;
less       return  LESSER;
equals           return EQUAL;
is      return EQUAL;
of      return OF;
the     return THE;
than    return THAN;
me      return PRONOUN;
us      return PRONOUN;
a       return WORD;
named   return WORD;
called  return WORD;
values return WORD;
as return WORD;
in return WORD;
with return WORD;
columns return WORD;
column return WORD;
put return INSERT;
entries return WORD;
data    return WORD;
use return USE;
datatype return DATATYPE;
datatypes return DATATYPE;
database    return DATABASE;
databases return DATABASE;
table       return TAB;
tables return TAB;
to      return TO;
[,]     return COMMA;
[a-zA-Z0-9)(']+	        return IDENTIFIER;
[.]         return END;
\n						return *yytext;
[ \t]+					/* ignore whitespace */;
%%