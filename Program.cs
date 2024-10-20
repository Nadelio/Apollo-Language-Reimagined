using static System.IO.File;
public class Entry
{
    public static void Main(string[] args)
    {
        string flags = args[0];
        string inputFilePath = args[1];
        string outputFilePath = args[2];
        if(Exists(inputFilePath) && inputFilePath.EndsWith(".sun")) {
            string content = ReadAllText(inputFilePath);
            string[] tokens = Lexer.Tokenize(content); // create Lexer class
            string[] parsedCode = Parser.Parse(tokens);
            string output = Transpiler.Transpile(parsedCode);
            WriteAllText(outputFilePath, output);
        } else {
            Console.WriteLine("Invalid file path");
        }
    }
}
