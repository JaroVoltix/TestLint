import ArgumentParser
import TuistPluginSwiftLintFramework

extension MainCommand {
    /// A command to lint the code using SwiftLint.
    struct SwiftLintCommand: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "swiftlint",
            abstract: "Lints the code of your projects using SwiftLint."
        )
        
        @Option(
            name: .shortAndLong,
            help: "The target name to be linted.",
            completion: .directory
        )
        var target: String?
        
        @Argument(
            help: "The filePaths to be linted. When not specified all the files in current firectory are linted."
        )
        var filePaths: [String] = ["."]
        
        @Flag(
            name: .shortAndLong,
            help: "Upgrades warnings to serious violations (errors)."
        )
        var strict: Bool = false
        
        func run() throws {
            if let target = target {
                try SwiftLintService()
                    .run(
                        targetName: target,
                        strict: strict
                    )
            }
            try SwiftLintService()
                .run(
                    paths: filePaths,
                    strict: strict
                )
        }
    }
}
