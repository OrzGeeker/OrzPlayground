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

extension List {
    init(@ListBuilder _ content: () -> [Row]) {
        rows = content()
    }
}

let buildBlockList = List {
    Row(title: "Row 1")
    Row(title: "Row 2")
}


//: [Next](@next)
