//: [Previous](@previous)

import Foundation

struct Row {
    let title: String
}
struct List {
    let rows: [Row]
}

@resultBuilder struct ListBuilder {
    static func buildBlock(_ components: Row...) -> [Row] {
        return components
    }
}

extension ListBuilder {
    static func buildExpression(_ expression: String) -> Row {
        return Row(title: expression)
    }
    static func buildExpression(_ expression: Row) -> Row {
        return expression
    }
}

extension List {
    init(@ListBuilder _ content: () -> [Row]) {
        rows = content()
    }
}

extension ListBuilder {
    static func buildEither(first component: [Row]) -> [Row] {
        return component
    }
    static func buildEither(second component: [Row]) -> [Row] {
        return component
    }
    static func buildBlock(_ components: [Row]...) -> [Row] {
        return components.flatMap { $0 }
    }
}

var a = 2
let buildEitherList = List {
    if a % 2 == 0 {
        "Row 1"
        Row(title: "Row 2")
    } else {
        "Row 3"
        "Row 4"
    }
}

//: [Next](@next)
