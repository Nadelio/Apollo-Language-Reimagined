using System.IO;

public class Entry
{
    public static void Main(string[] args)
    {
        string flags = args[0];
        string inputFilePath = args[1];
        string outputFilePath = args[2];
        if (File.Exists(inputFilePath) && inputFilePath.EndsWith(".sun"))
        {
            string content = File.ReadAllText(inputFilePath);
        }
        else
        {
            Console.WriteLine("Invalid file path");
        }
    }
}
