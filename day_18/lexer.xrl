Definitions.

NUM = [0-9]+
WS  = [\n\r\t\s]+

Rules.

{NUM} : {token, {num, TokenLine, list_to_integer(TokenChars)}}.
\+    : {token, {'+', TokenLine}}.
\*    : {token, {'*', TokenLine}}.
\(    : {token, {'(', TokenLine}}.
\)    : {token, {')', TokenLine}}.
{WS}+ : skip_token.

Erlang code.

