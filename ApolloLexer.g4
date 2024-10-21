lexer grammar ApolloLexer;

// $antlr-format alignTrailingComments true, columnLimit 80, minEmptyLines 1, maxEmptyLinesToKeep 1, reflowComments false, useTab false
// $antlr-format allowShortRulesOnASingleLine false, allowShortBlocksOnASingleLine true, alignSemicolons hanging, alignColons hanging

channels {
    ANNOTATION_CHANNEL,
    COMMENTS_CHANNEL
}

COMMENT
    : SINGLE_LINE_COMMENT
    | DELIMITED_COMMENT
    ;

SINGLE_LINE_COMMENT
    : '//' InputCharacter* -> channel(COMMENTS_CHANNEL)
    ;

DELIMITED_COMMENT
    : '/*' .*? '*/' -> channel(COMMENTS_CHANNEL)
    ;

WHITESPACES
    : (Whitespace | Newline)+ -> channel(HIDDEN)
    ;

ATTRIBUTE_START
    : '@' IDENTIFIER OPEN_BRACE -> pushMode(ANNOTATION_MODE)
    ;

ANY
    : 'any'
    ;

BOOL
    : 'bool'
    ;

BYTE
    : 'byte'
    ;

CHAR
    : 'char'
    ;

DOUBLE
    : 'double'
    ;

DEC
    : 'dec'
    ;

ELIF
    : 'elif'
    ;

ELSE
    : 'else'
    ;

FALSE
    : 'False'
    ;

FLOAT
    : 'float'
    ;

FUNCTION
    : 'function'
    ;

IF
    : 'if'
    ;

INC
    : 'inc'
    ;

INT
    : 'int'
    ;

LEN
    : 'len'
    ;

LONG
    : 'long'
    ;

UINT
    : 'uint'
    ;

ULONG
    : 'ulong'
    ;

USHORT
    : 'ushort'
    ;

LOOP
    : 'loop'
    ;

NEW
    : 'new'
    ;

NULL
    : 'null'
    ;

PRINT
    : 'print'
    ;

SET
    : 'set'
    ;

SBYTE
    : 'sbyte'
    ;

SHORT
    : 'short'
    ;

STDIN
    : 'stdin'
    ;

STRING
    : 'string'
    ;

TRUE
    : 'True'
    ;

// Operators and punctuators

OPEN_BRACE
    : '{'
    ;

CLOSE_BRACE
    : '}'
    ;

OPEN_BRACKET
    : '['
    ;

CLOSE_BRACKET
    : ']'
    ;

OPEN_PARENS
    : '('
    ;

CLOSE_PARENS
    : ')'
    ;

DOT
    : '.'
    ;

COMMA
    : ','
    ;

COLON
    : ':'
    ;

SEMICOLON
    : ';'
    ;

PLUS
    : '+'
    ;

MINUS
    : '-'
    ;

STAR
    : '*'
    ;

DIV
    : '/'
    ;

PERCENT
    : '%'
    ;

AMP
    : '&'
    ;

PIPE
    : '|'
    ;

CARET
    : '^'
    ;

BANG
    : '!'
    ;

TILDE
    : '~'
    ;

LT
    : '<'
    ;

GT
    : '>'
    ;

OP_AND
    : '&&'
    ;

OP_OR
    : '||'
    ;

OP_LEFT_ARROW
    : '<-'
    ;

OP_RIGHT_ARROW
    : '->'
    ;

OP_SHIFT_LEFT
    : '<<'
    ;

OP_SHIFT_RIGHT
    : '>>'
    ;

OP_EQ
    : '=='
    ;

OP_NEQ
    : '!='
    ;

OP_LE
    : '<='
    ;

OP_GE
    : '>='
    ;

IDENTIFIER
    : IdentifierOrKeyword
    ;

LITERAL
    : BOOLEAN_LITERAL
    | INTEGER_LITERAL
    | REAL_LITERAL
    | CHARACTER_LITERAL
    | STRING_LITERAL
    | NULL_LITERAL
    ;

BOOLEAN_LITERAL
    : TRUE
    | FALSE
    ;

NULL_LITERAL
    : NULL
    ;

INTEGER_LITERAL
    : DEC_INTEGER_LITERAL
    | HEX_INTEGER_LITERAL
    | BIN_INTEGER_LITERAL
    ;

DEC_INTEGER_LITERAL
    : DecimalDigit+ IntegerTypeSuffix?
    ;

HEX_INTEGER_LITERAL
    : '0' [xX] HexDigit+ IntegerTypeSuffix?
    ;

BIN_INTEGER_LITERAL
    : '0' [bB] BinDigit+ IntegerTypeSuffix?
    ;

REAL_LITERAL
    : ([0-9]*)? DOT [0-9]* ExponentPart? FloatTypeSuffix?
    | [0-9]* (
        FloatTypeSuffix
        | ExponentPart FloatTypeSuffix?
    )
    ;

CHARACTER_LITERAL
    : '\'' (
        ~['\\\r\n\u0085\u2028\u2029]
        | EscapeSequence
    ) '\''
    ;

STRING_LITERAL
    : '"' (
        ~["\\\r\n\u0085\u2028\u2029]
        | EscapeSequence
    )* '"'
    ;

mode ANNOTATION_MODE;

ANNOTATION_CONTENT
    : ~[{}]+
    ;

ANNOTATION_END
    : CLOSE_BRACE -> popMode
    ;

// ==== Fragments ====

fragment EscapeSequence
    : SimpleEscapeSequence
    | HexEscapeSequence
    | UnicodeEscapeSequence
    ;

fragment SimpleEscapeSequence
    : '\\\''
    | '\\"'
    | '\\\\'
    | '\\0'
    | '\\a'
    | '\\b'
    | '\\f'
    | '\\n'
    | '\\r'
    | '\\t'
    | '\\v'
    ;

fragment HexEscapeSequence
    : '\\x' HexDigit
    | '\\x' HexDigit HexDigit
    | '\\x' HexDigit HexDigit HexDigit
    | '\\x' HexDigit HexDigit HexDigit HexDigit
    ;

fragment DecimalDigit
    : [0-9]
    ;

fragment HexDigit
    : [0-9]
    | [A-F]
    | [a-f]
    ;

fragment BinDigit
    : [01]
    ;

fragment IntegerTypeSuffix
    : [lL]? [uU]
    | [uU]? [lL]
    ;

fragment FloatTypeSuffix
    : [fF]
    | [dD]
    ;

fragment ExponentPart
    : [eE] ('+' | '-')? [0-9]*
    ;

fragment InputCharacter
    : ~[\r\n\u0085\u2028\u2029]
    ;

fragment Newline
    : '\r\n'
    | '\r'
    | '\n'
    | '\u0085' // <Next Line CHARACTER (U+0085)>'
    | '\u2028' //'<Line Separator CHARACTER (U+2028)>'
    | '\u2029' //'<Paragraph Separator CHARACTER (U+2029)>'
    ;

fragment NewLineCharacter
    : '\u000D' //'<Carriage Return CHARACTER (U+000D)>'
    | '\u000A' //'<Line Feed CHARACTER (U+000A)>'
    | '\u0085' //'<Next Line CHARACTER (U+0085)>'
    | '\u2028' //'<Line Separator CHARACTER (U+2028)>'
    | '\u2029' //'<Paragraph Separator CHARACTER (U+2029)>'
    ;

fragment Whitespace
    : UnicodeClassZS //'<Any Character With Unicode Class Zs>'
    | '\u0009'       //'<Horizontal Tab Character (U+0009)>'
    | '\u000B'       //'<Vertical Tab Character (U+000B)>'
    | '\u000C'       //'<Form Feed Character (U+000C)>'
    ;

fragment UnicodeClassZS
    : '\u0020' // SPACE
    | '\u00A0' // NO_BREAK SPACE
    | '\u1680' // OGHAM SPACE MARK
    | '\u180E' // MONGOLIAN VOWEL SEPARATOR
    | '\u2000' // EN QUAD
    | '\u2001' // EM QUAD
    | '\u2002' // EN SPACE
    | '\u2003' // EM SPACE
    | '\u2004' // THREE_PER_EM SPACE
    | '\u2005' // FOUR_PER_EM SPACE
    | '\u2006' // SIX_PER_EM SPACE
    | '\u2008' // PUNCTUATION SPACE
    | '\u2009' // THIN SPACE
    | '\u200A' // HAIR SPACE
    | '\u202F' // NARROW NO_BREAK SPACE
    | '\u3000' // IDEOGRAPHIC SPACE
    | '\u205F' // MEDIUM MATHEMATICAL SPACE
    ;

fragment IdentifierOrKeyword
    : IdentifierStartCharacter IdentifierPartCharacter*
    ;

fragment IdentifierStartCharacter
    : LetterCharacter
    | '_'
    ;

fragment LetterCharacter
    : [\p{Lu}\p{Ll}\p{Lt}\p{Lm}\p{Lo}\p{Nl}]
    | UnicodeEscapeSequence
    ;

fragment UnicodeEscapeSequence
    : '\\u' HexDigit HexDigit HexDigit HexDigit
    | '\\U' HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit HexDigit
        HexDigit
    ;

fragment IdentifierPartCharacter
    : LetterCharacter
    | DecimalDigit
    | [\p{Mn}\p{Mc}\p{Cf}]
    | '_'
    ;