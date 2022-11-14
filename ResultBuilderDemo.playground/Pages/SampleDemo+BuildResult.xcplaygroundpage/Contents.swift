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
        return components.flatMap{ $0 }
    }
    static func buildExpression(_ expression: String) -> [Row] {
        return [Row(title: expression)]
    }
}
extension List {
    init(@ListBuilder _ content: () -> [Row]) {
        rows = content()
    }
}
extension ListBuilder {
    static func buildArray(_ components: [[Row]]) -> [Row] {
        return components.flatMap { $0 }
    }
}

enum RowEnum: String, CaseIterable {
    case row1
    case row2
    case row3
}

extension ListBuilder {
    static func buildFinalResult(_ component: [Row]) -> [Row] {
        return component.map {
            Row(title: "Simple Demo: \($0.title)")
        }
    }
}
let buildResultList = List {
    for row in RowEnum.allCases {
        row.rawValue
    }
}

//: [Next](@next)
