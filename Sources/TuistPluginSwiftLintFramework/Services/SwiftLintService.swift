import Foundation
import ProjectAutomation

enum SwiftLintServiceError: Error, CustomStringConvertible, Equatable {
    /// Thrown when a graph can not be found at the given path.
    case graphNotFound
    
    /// Thrown when target with given name does not exist.
    case targetNotFound(targetName: String)
    
    /// Error description.
    var description: String {
        switch self {
        case .graphNotFound:
            return "The project's graph can not be found. Run tuist to fix that"
        case .targetNotFound(let targetName):
            return "A target with a name '\(targetName)' not found in the project."
        }
    }
}

/// A service that manages code linting.
public final class SwiftLintService {
    private let swiftLintAdapter: SwiftLintFrameworkAdapting
    
    public init(
        swiftLintAdapter: SwiftLintFrameworkAdapting = SwiftLintFrameworkAdapter()
    ) {
        self.swiftLintAdapter = swiftLintAdapter
    }
    
    /// The entry point of the service. Invoke it to start linting.
    /// - Parameters:
    ///   - targetName: The target to be linted. When not specified all the targets of the graph are linted.
    ///   - strict: If `true` then warnings will be updated to serious violations (errors).
    public func run(targetName: String?, strict: Bool) throws {
        let graph = try getGraph(at: nil)
        let sourcesToLint = try getSourcesToLint(in: graph, targetName: targetName)
        
        let leniency: Leniency = strict ? .strict : .default
        
        swiftLintAdapter.lint(
            paths: sourcesToLint,
            configurationFiles: [],
            leniency: leniency,
            quiet: false
        )
    }
    
    public func run(paths: [String], strict: Bool) throws {
        swiftLintAdapter.lint(
            paths: paths,
            configurationFiles: [],
            leniency: .default,
            quiet: false)
    }
    
    private func getGraph(at path: String?) throws -> Graph {
        do {
            return try Tuist.graph(at: path)
        } catch {
            throw SwiftLintServiceError.graphNotFound
        }
    }
    
    private func getSourcesToLint(in graph: Graph, targetName: String?) throws -> [String] {
        if let targetName = targetName {
            guard let target = graph.allInternalTargets.first(where: { $0.name == targetName }) else {
                throw SwiftLintServiceError.targetNotFound(targetName: targetName)
            }
            
            return target.sources
        }
        
        return graph.allInternalTargets
            .flatMap { $0.sources }
    }
}

private extension Graph {
    /// Returns a list of targets that are included into the graph and are not 3rd party dependencies.
     var allInternalTargets: [Target] {
         projects.values
             .filter { !$0.isExternal }
             .flatMap { $0.targets }
     }
}
