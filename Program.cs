using CommandLine;

public class Entry
{
    public class Options
    {
        [Option('v', "verbose", Required = false, HelpText = "Enable verbose output.")]
        public bool Verbose { get; set; }

        [Option('i', "input", Required = true, HelpText = "Input file path.")]
        public string? InputFilePath { get; set; }

        [Option('o', "output", Required = false, HelpText = "Output file path.")]
        public string? OutputFilePath { get; set; }
    }

    public static void Main(string[] args)
    {
        CommandLine.Parser.Default
            .ParseArguments<Options>(args)
            .WithParsed(Run)
            .WithNotParsed(HandleParseError);
    }

    private static void Run(Options opts)
    {
        if (opts.Verbose)
        {
            Console.WriteLine("Verbose mode enabled");
        }

        if (!File.Exists(opts.InputFilePath) || !opts.InputFilePath!.EndsWith(".sun"))
        {
            Console.WriteLine("Invalid or non-existent input file. Please provide a valid .sun file.");
            return;
        }

        string outputFilePath = opts.OutputFilePath ?? Path.ChangeExtension(opts.InputFilePath, ".out");

        if (opts.Verbose)
        {
            Console.WriteLine($"Processing file: {opts.InputFilePath}");
            Console.WriteLine($"Output will be saved to: {outputFilePath}");
        }

        string content = File.ReadAllText(opts.InputFilePath);
        string transpiledContent = content; //SimulateProcessing(content);
        File.WriteAllText(outputFilePath, transpiledContent);

        if (opts.Verbose)
        {
            Console.WriteLine("File processed successfully.");
        }
    }

    private static void HandleParseError(IEnumerable<Error> errs)
    {
        foreach (var error in errs)
        {
            if (error is MissingRequiredOptionError missingOptionError)
            {
                Console.WriteLine($"Missing required option: {missingOptionError.NameInfo.NameText}");
            }
            else
            {
                Console.WriteLine("Error parsing arguments.");
            }
        }
    }
}
