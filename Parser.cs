using System;
public class Parser
{
    enum Expectations
    {
        TYPE_DECLARATION,
        TYPE_ARRAY,
        VARIABLE_NAME,
        VARIABLE_VALUE_INT,
        VARIABLE_VALUE_STRING,
        VARIABLE_VALUE_BOOL,
        VARIABLE_VALUE_CHAR,
        VARIABLE_VALUE_ANY
    }

    private static int tokenIndex = 0;

    public static string[] Parse(string[] tokens)
    {
        List<string> parsedTokens = new List<string>();

        for(tokenIndex = 0; tokenIndex < tokens.Length; tokenIndex++) {
            switch (tokens[tokenIndex]) {
                case "new":
                    int tokenJump = 0;
                    string IRToken = "<new>";
                    if (Expect(tokens[tokenIndex + 1], Expectations.TYPE_DECLARATION)) {
                        IRToken += "<" + tokens[tokenIndex + 1] + ">";
                        if (Expect(tokens[tokenIndex + 2], Expectations.VARIABLE_NAME)) {
                            IRToken += "<" + tokens[tokenIndex + 2] + ">";
                        } else if (Expect(tokens[tokenIndex + 2], Expectations.TYPE_ARRAY)) {
                            int i = 3;
                            IRToken += "<[]>";
                            while (Expect(tokens[tokenIndex + i], Expectations.TYPE_ARRAY)) {
                                IRToken += "<" + tokens[tokenIndex + i] + ">";
                                i++;
                            }
                            tokenJump += i;
                        } else {
                            throw new Exception("Expected variable name or array declaration @ " + tokenIndex + ". Received: " + tokens[tokenIndex + 2]);
                        }
                    } else {
                        throw new Exception("Expected type declaration @ " + tokenIndex + ". Received: " + tokens[tokenIndex + 1]);
                    }
                    break;
            }
        }

        return parsedTokens.ToArray();
    }

    private static bool Expect(string token, Expectations expectation)
    {
        switch (expectation)
        {
            case Expectations.TYPE_DECLARATION:
                if (token != "int" && token != "string" && token != "bool" && token != "char" && token != "any")
                {
                    throw new Exception("Invalid type declaration @" + tokenIndex + " : " + token + ".");
                } else {
                    return true;
                }
            case Expectations.TYPE_ARRAY:
                if (token != "[]") {
                    throw new Exception("Expected array declaration @" + tokenIndex + ". Recieved: " + token + ".");
                } else {
                    return true;
                }
            default:
                return false;
        }
    }
}
