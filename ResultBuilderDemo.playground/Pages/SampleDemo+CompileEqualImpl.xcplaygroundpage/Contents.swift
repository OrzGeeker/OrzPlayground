//: [Previous](@previous)

import Foundation

struct Row {
    let title: String
}
struct List {
    let rows: [Row]
}

// MARK: 编译时等价实现
struct ListBuilder {
    static func buildBlock(_ components: Row...) -> [Row] {
        return components
    }
}
extension List {
    init(_ content: () -> [Row]) {
        rows = content()
    }
}
let compileTimeBuildBlockList = List {
    let v1 = Row(title: "Row 1")
    let v2 = Row(title: "Row 2")
    return ListBuilder.buildBlock(v1,v2)
}

// MARK: buildExpression(_:)
extension ListBuilder {
    static func buildExpression(_ expression: String) -> Row {
        return Row(title: expression)
    }
    static func buildExpression(_ expression: Row) -> Row {
        return expression
    }
}
let compileTimeBuildExpressionList = List {
    let v1 = ListBuilder.buildExpression("Row 1")
    let v2 = ListBuilder.buildExpression(Row(title: "Row 2"))
    return ListBuilder.buildBlock(v1,v2)
}

extension ListBuilder {
    
    static func buildBlock(_ components: [Row]...) -> [Row] {
        return components.flatMap { $0 }
    }
    
    static func buildOptional(_ component: [Row]?) -> [Row] {
        return component ?? []
    }
}

var a = 1
let compileTimeBuildOptionalList = List {
    var v1: [Row]?
    if a % 2 == 0 {
        let v2 = ListBuilder.buildExpression("Row 1")
        let v3 = ListBuilder.buildExpression(Row(title: "Row 2"))
        v1 = ListBuilder.buildBlock(v2, v3)
    }
    let v4 = ListBuilder.buildOptional(v1)
    return ListBuilder.buildBlock(v4)
}


extension ListBuilder {
    static func buildEither(first component: [Row]) -> [Row] {
        return component
    }
    static func buildEither(second component: [Row]) -> [Row] {
        return component
    }
}


let compileTimeBuildEitherList = List {
    var v1: [Row]
    if a % 2 == 0 {
        let v2 = ListBuilder.buildExpression("Row 1")
        let v3 = ListBuilder.buildExpression(Row(title: "Row 2"))
        let v4 = ListBuilder.buildBlock(v2,v3)
        v1 = ListBuilder.buildEither(first: v4)
    } else {
        let v2 = ListBuilder.buildExpression("Row 3")
        let v3 = ListBuilder.buildExpression("Row 4")
        let v4 = ListBuilder.buildBlock(v2,v3)
        v1 = ListBuilder.buildEither(second: v4)
    }
    return ListBuilder.buildBlock(v1)
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

let compileTimeBuildArrayList = List {
    var v1 = [[Row]]()
    for row in RowEnum.allCases {
        let v2 = ListBuilder.buildExpression(row.rawValue)
        let v3 = ListBuilder.buildBlock(v2)
        v1.append(v3)
    }
    let v4 = ListBuilder.buildArray(v1)
    return ListBuilder.buildBlock(v4)
}

extension ListBuilder {
    static func buildFinalResult(_ component: [Row]) -> [Row] {
        return component.map {
            Row(title: "Simple Demo: \($0.title)")
        }
    }
}

let compileTimeBuildResultList = List {
    var v1 = [[Row]]()
    for row in RowEnum.allCases {
        let v2 = ListBuilder.buildExpression(row.rawValue)
        let v3 = ListBuilder.buildBlock(v2)
        v1.append(v3)
    }
    let v4 = ListBuilder.buildArray(v1)
    let v5 = ListBuilder.buildBlock(v4)
    return ListBuilder.buildFinalResult(v5)
}
//: [Next](@next)
