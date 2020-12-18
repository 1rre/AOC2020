Nonterminals op.
Terminals '(' ')' num '+' '*'.

Rootsymbol op.

Left 200 '+'. % Change to 100 for part 1
Left 100 '*'.


op -> '(' op ')' : '$2'.
op -> op '*' op  : {'$2', {'$1', '$3'}}.
op -> op '+' op  : {'$2', {'$1', '$3'}}.
op -> num        : '$1'.
