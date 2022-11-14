//: [Previous](@previous)

import Foundation

struct Row {
    let title: String
}
struct List {
    let rows: [Row]
}

@resultBuilder struct ListBuilder {
    static func buildBlock(_ components: [Row]...) -> [Row] {
        return components.flatMap { $0 }
    }
}

extension ListBuilder {
    static func buildExpression(_ expression: String) -> [Row] {
        return [Row(title: expression)]
    }
    static func buildExpression(_ expression: Row) -> [Row] {
        return [expression]
    }
    static func buildExpression(_ expression: Void) -> [Row] {
        return []
    }
}

extension List {
    init(@ListBuilder _ content: () -> [Row]) {
        rows = content()
    }
}

let buildExpressionList = List {
    "Row 1"
    Row(title: "Row 2")
    print("log")
}
//: [Next](@next)
