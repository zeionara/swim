// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct StringifyMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let argument = node.argumentsList.first?.expression else {
            fatalError("compiler bug: the macro does not have any arguments")
        }

        return "(\(argument), \(literal: argument.description))"
    }
}

@freestanding(expression)
macro stringify<T>(_ value: T) -> (T, String) = #externalMacro(module: "WWDCMacros", type: "StringifyMacro")

let calculations = [
    #stringify(1 + 1),
    #stringify(2 + 3)
]

// print("Hello, world!")
print(calculations)
